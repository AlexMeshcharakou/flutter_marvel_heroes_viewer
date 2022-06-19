import 'package:dio/dio.dart';
import 'package:marvel/data/data_sources/local_character_data_source.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/exceptions/exceptions.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';
import 'package:marvel/data/converters/converter.dart';

class DefaultMarvelRepository implements MarvelRepository {
  final DioDataSource dioDataSource;
  final HiveDataSource? hiveDataSource;
  late int offset;
  late List<Character> characters;

  DefaultMarvelRepository({this.hiveDataSource, required this.dioDataSource});

  @override
  Future<List<Character>> getCharacters(int offset) async {
    if (offset == 0) {
      try {
        final httpResponse = await dioDataSource.getCharacters(offset);
        if (httpResponse.response.statusCode != 200) {
          throw DataRetrievingException();
        }
        final result = httpResponse.data.data.results;
        characters = result
            .map(
              (remoteCharacter) => remoteCharacter.characterToDomainModel(remoteCharacter),
            )
            .toList();
        _saveCharactersToDB(characters);
      } on DioError {
        _getCharactersFromLocal();
      }
      return characters;
    }
    try {
      final httpResponse = await dioDataSource.getCharacters(offset);
      if (httpResponse.response.statusCode != 200) {
        throw DataRetrievingException();
      }
      final result = httpResponse.data.data.results;
      characters = result
          .map(
            (remoteCharacter) => remoteCharacter.characterToDomainModel(remoteCharacter),
          )
          .toList();
    } on DioError {
      throw NoInternetException();
    }
    return characters;
  }

  @override
  Future<Character> getCharacterDetails(int characterId) async {
    try {
      final httpResponse = await dioDataSource.getCharacterDetails(characterId);
      if (httpResponse.response.statusCode != 200) {
        throw DataRetrievingException();
      }
      final result = httpResponse.data.data.results;
      Character character = result
          .map(
            (characterResponse) => characterResponse.detailsToDomainModel(characterResponse),
          )
          .single;
      return character;
    } on DioError {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Series>> getAllSeries(int characterId) async {
    try {
      final httpResponse = await dioDataSource.getAllSeries(characterId);
      if (httpResponse.response.statusCode != 200) {
        throw DataRetrievingException();
      }
      final result = httpResponse.data.data.results;
      List<Series> allSeries = result
          .map(
            (seriesResponse) => seriesResponse.seriesToDomainModel(seriesResponse),
          )
          .toList();
      return allSeries;
    } on DioError {
      throw NoInternetException();
    }
  }

  List<Character> _getCharactersFromLocal() {
    if (hiveDataSource!.getAll().isNotEmpty) {
      List<LocalCharacter> localCharacters = hiveDataSource!.getAll();
      characters = localCharacters.map((hero) => hero.localCharacterToDomainModel(hero)).toList();
      return characters;
    }
    throw DataRetrievingException();
  }

  void _saveCharactersToDB(List<Character> characters) {
    List<LocalCharacter> localCharacters = characters.map((hero) => hero.domainModelToLocalCharacter(hero)).toList();
    hiveDataSource?.save(localCharacters);
  }
}
