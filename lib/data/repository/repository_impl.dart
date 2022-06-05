import 'package:marvel/data/data_sources/local_data_source.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';
import 'package:marvel/data/converters/converter.dart';

class RepositoryImpl implements MarvelRepository {
  final DioDataSource? dioDataSource;
  final HiveDataSource? hiveDataSource;

  RepositoryImpl({this.hiveDataSource, this.dioDataSource});

  @override
  Future<List<Character>> getCharacters(int offset) async {
    try {
      List<Character> characters = await dioDataSource!.getCharacters(offset);
      List<LocalCharacter> localCharacters = characters.map((hero) => domainModelToLocalCharacter(hero)).toList();
      if (offset == 0) {
        hiveDataSource?.deleteAll();
        for (var character in localCharacters) {
          hiveDataSource?.save(character);
        }
      }
      return characters;
    } catch (DioError) {
      List<LocalCharacter> localCharacters = hiveDataSource!.getAll();
      List<Character> characters = localCharacters.map((hero) => localCharacterToDomainModel(hero)).toList();
      return characters;
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
}
