import 'package:dio/dio.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:marvel/data/repository/repository.dart';
import 'package:marvel/data/sources/marvel_api_client.dart';

class RepositoryImpl extends Repository {
  final MarvelApiClient marvelClient = MarvelApiClient(Dio(), baseUrl: 'https://gateway.marvel.com:443/v1/public/');
  final String ts = '2';
  final String apiKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  @override
  Future<List<Character>> fetchCharacters() async {
    try {
      final httpResponse = await marvelClient.fetchCharacters(ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final Map<String, dynamic> apiResponse = httpResponse.response.data;
      final apiResponseData = ApiResponse.fromJson(apiResponse);
      final result = apiResponseData.data.results;
      List<Character> characters = result
          .map(
            (item) => Character(id: item.id, name: item.name, description: item.description, thumbnail: item.thumbnail),
          )
          .toList();
      return characters;
    } catch (error) {
      return Future.error("$error");
    }
  }

  @override
  Future<Character> fetchCharacterDetails(int characterId) async {
    try {
      final httpResponse = await marvelClient.fetchCharacterDetails(characterId, ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final Map<String, dynamic> apiResponse = httpResponse.response.data;
      final apiResponseData = ApiResponse.fromJson(apiResponse);
      final result = apiResponseData.data.results;
      Character character = result
          .map(
            (item) => Character(id: item.id, name: item.name, description: item.description, thumbnail: item.thumbnail),
          )
          .single;
      return character;
    } catch (error) {
      return Future.error("$error");
    }
  }

  @override
  Future<List<Series>> fetchSeries(int characterId) async {
    try {
      final httpResponse = await marvelClient.fetchSeries(characterId, ts, apiKey, hash);
      if (httpResponse.response.statusCode != 200) {
        return Future.error("network error");
      }
      final Map<String, dynamic> seriesResponse = httpResponse.response.data;
      final seriesResponseData = SeriesResponse.fromJson(seriesResponse);
      final data = seriesResponseData.data;
      List<Series>? allSeries = data.results
          .map(
            (item) => Series(title: item.title, description: item.description, thumbnail: item.thumbnail),
          )
          .toList();
      return allSeries;
    } catch (error) {
      return Future.error("$error");
    }
  }
}
