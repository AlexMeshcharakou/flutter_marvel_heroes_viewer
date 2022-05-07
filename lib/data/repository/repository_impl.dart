import 'package:dio/dio.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/repository/repository.dart';
import 'package:marvel/data/repository/sources/marvell_api_client.dart';

class RepositoryImpl extends Repository {
  final MarvelClient marvelClient = MarvelClient(
      Dio(BaseOptions(contentType: 'application/json', responseType: ResponseType.plain)),
      baseUrl: 'https://gateway.marvel.com:443/v1/public/');
  final String ts = '2';
  final String publicKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  @override
  Future<List<Character>> fetchCharacters() async {
    try {
      final httpResponse = await marvelClient.fetchCharacters(ts, publicKey, hash);
      if (httpResponse.response.statusCode != 200) {
        print(httpResponse.response.statusCode);
        return Future.error("network error");
      }
      print(httpResponse.response.statusCode);
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
}
