import 'package:dio/dio.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:retrofit/retrofit.dart';

part 'marvel_api_client.g.dart';

@RestApi(baseUrl: 'https://gateway.marvel.com:443/v1/public/')
abstract class MarvelApiClient {
  factory MarvelApiClient(Dio dio, {String baseUrl}) = _MarvelApiClient;

  @GET('/characters')
  Future<HttpResponse<ApiResponseModel>> getCharacters(
    @Query('ts') String ts,
    @Query('apikey') String apiKey,
    @Query('hash') String hash,
  );

  @GET("/characters/{characterId}")
  Future<HttpResponse<ApiResponseModel>> getCharacterDetails(
    @Path("characterId") int characterId,
    @Query("ts") String ts,
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
  );

  @GET("/characters/{characterId}/series")
  Future<HttpResponse<SeriesResponseModel>> getAllSeries(
    @Path("characterId") int characterId,
    @Query("ts") String ts,
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
  );
}