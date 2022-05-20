import 'package:dio/dio.dart';
import 'package:marvel/data/sources/marvel_api_client.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';
import 'package:marvel/data/convertors/convertor.dart';

class RepositoryImpl implements MarvelRepository {
  final MarvelApiClient marvelClient = MarvelApiClient(Dio(), baseUrl: 'https://gateway.marvel.com:443/v1/public/');
  final String ts = '2';
  final String apiKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  RepositoryImpl._();

  static final RepositoryImpl _repositoryImpl = RepositoryImpl._();

  factory RepositoryImpl() => _repositoryImpl;

  @override
  Future<List<Character>> getCharacters() async {
    try {
      final httpResponse = await marvelClient.getCharacters(ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final result = httpResponse.data.data.results;
      List<Character> characters = result
          .map(
            (characterResponse) => characterResponse.characterToDomainModel(characterResponse),
          )
          .toList();
      return characters;
    } catch (error) {
      return Future.error("$error");
    }
  }

  @override
  Future<Character> getCharacterDetails(int characterId) async {
    try {
      final httpResponse = await marvelClient.getCharacterDetails(characterId, ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final result = httpResponse.data.data.results;
      Character character = result
          .map(
            (characterResponse) => characterResponse.detailsToDomainModel(characterResponse),
          )
          .single;
      return character;
    } catch (error) {
      return Future.error("$error");
    }
  }

  @override
  Future<List<Series>> getAllSeries(int characterId) async {
    try {
      final httpResponse = await marvelClient.getAllSeries(characterId, ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final result = httpResponse.data.data.results;
      List<Series> allSeries = result
          .map(
            (seriesResponse) => seriesResponse.seriesToDomainModel(seriesResponse),
          )
          .toList();
      return allSeries;
    } catch (error) {
      return Future.error("$error");
    }
  }
}
