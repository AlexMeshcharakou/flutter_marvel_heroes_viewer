import 'package:dio/dio.dart';
import 'package:marvel/data/converters/converter.dart';
import 'package:marvel/data/data_sources/marvel_api_client.dart';
import 'package:marvel/data/models/remote_models/character_model.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:retrofit/retrofit.dart';

abstract class RemoteDataSource {
  Future<HttpResponse<ApiResponseModel>> getCharacters(int offset);

  Future<Character> getCharacterDetails(int characterId);

  Future<List<Series>> getAllSeries(int characterId);
}

class DioDataSource implements RemoteDataSource {
  final MarvelApiClient marvelClient = MarvelApiClient(Dio(BaseOptions(connectTimeout: 7000, receiveTimeout: 7000)),
      baseUrl: 'https://gateway.marvel.com:443/v1/public/');
  final String ts = '2';
  final String apiKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  @override
  Future<HttpResponse<ApiResponseModel>> getCharacters(int offset) async {
    return await marvelClient.getCharacters(ts, apiKey, hash, offset);
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
