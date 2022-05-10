import 'package:dio/dio.dart';
import 'package:marvel/data/models/character.dart';
import 'package:retrofit/retrofit.dart';

part 'marvell_api_client.g.dart';

@RestApi(baseUrl: 'https://gateway.marvel.com:443/v1/public')
abstract class MarvelClient {
  factory MarvelClient(Dio dio, {String baseUrl}) = _MarvelClient;

  @GET('/characters')
  Future<HttpResponse<Character>> fetchCharacters(
    @Query('ts') String ts,
    @Query('apikey') String publicKey,
    @Query('hash') String hash,
  );
}
