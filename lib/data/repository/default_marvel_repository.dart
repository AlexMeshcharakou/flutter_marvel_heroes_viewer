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
        List<Character> characters = result
            .map(
              (characterResponse) => characterResponse.characterToDomainModel(characterResponse),
            )
            .toList();
        List<LocalCharacter> localCharacters =
            characters.map((hero) => hero.domainModelToLocalCharacter(hero)).toList();
        hiveDataSource?.save(localCharacters);
        return characters;
      } on DioError {
        return _getLocalCharacters();
      }
    }
    try {
      return _getRemoteCharacters(offset);
    } on DioError {
      throw NoInternetException();
    }
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

  Future<List<Character>> _getRemoteCharacters(int offset) async {
    final httpResponse = await dioDataSource.getCharacters(offset);
    if (httpResponse.response.statusCode != 200) {
      throw DataRetrievingException();
    }
    final result = httpResponse.data.data.results;
    List<Character> characters = result
        .map(
          (characterResponse) => characterResponse.characterToDomainModel(characterResponse),
        )
        .toList();
    return characters;
  }

  List<Character> _getLocalCharacters() {
    if (hiveDataSource!.getAll().isNotEmpty) {
      List<LocalCharacter> localCharacters = hiveDataSource!.getAll();
      List<Character> characters = localCharacters.map((hero) => hero.localCharacterToDomainModel(hero)).toList();
      return characters;
    }
    throw DataRetrievingException();
  }
}
