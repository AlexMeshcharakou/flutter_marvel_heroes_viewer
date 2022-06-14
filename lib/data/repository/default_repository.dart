import 'package:dio/dio.dart';
import 'package:marvel/data/data_sources/local_character_data_source.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/exceptions/exceptions.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';
import 'package:marvel/data/converters/converter.dart';

class DefaultRepository implements MarvelRepository {
  final DioDataSource? dioDataSource;
  final HiveDataSource? hiveDataSource;
  bool onceLoaded = false;
  late int offset;

  DefaultRepository({this.hiveDataSource, this.dioDataSource});

  @override
  Future<List<Character>> getCharacters(int offset) async {
    try {
      if (!onceLoaded) {
        return _getCharactersFromLocalDB();
      } else {
        final httpResponse = await dioDataSource!.getCharacters(offset);
        if (httpResponse.response.statusCode != 200) {
          throw DataRetrievingException();
        }
        final result = httpResponse.data.data.results;
        List<Character> characters = result
            .map(
              (characterResponse) => characterResponse.characterToDomainModel(characterResponse),
            )
            .toList();
        List<LocalCharacter> localCharacters =
            characters.map((hero) => hero.domainModelToLocalCharacter(hero)).toList();
        if (offset == 0) {
          hiveDataSource?.deleteAll();
          for (var character in localCharacters) {
            hiveDataSource?.save(character);
          }
        }
        return characters;
      }
    } on DioError catch (ex) {
      if (onceLoaded) {
        throw NoInternetException;
      } else {
        return _getCharactersFromLocalDB();
      }
    }
  }

  @override
  Future<Character> getCharacterDetails(int characterId) async {
    return await dioDataSource!.getCharacterDetails(characterId);
  }

  @override
  Future<List<Series>> getAllSeries(int characterId) async {
    return await dioDataSource!.getAllSeries(characterId);
  }

  List<Character> _getCharactersFromLocalDB() {
    List<LocalCharacter> localCharacters = hiveDataSource!.getAll();
    List<Character> characters = localCharacters.map((hero) => hero.localCharacterToDomainModel(hero)).toList();
    onceLoaded = true;
    return characters;
  }
}
