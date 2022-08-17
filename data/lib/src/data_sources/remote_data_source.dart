import 'package:data/data_module.dart';
import 'package:data/src/models/remote_models/character_model.dart';
import 'package:data/src/models/remote_models/series_model.dart';
import 'package:retrofit/retrofit.dart';

abstract class RemoteDataSource {
  Future<HttpResponse<ApiResponseModel>> getCharacters(int offset);

  Future<HttpResponse<ApiResponseModel>> getCharacterDetails(int characterId);

  Future<HttpResponse<SeriesResponseModel>> getAllSeries(int characterId);

  Future<HttpResponse<ApiResponseModel>> searchCharacters(String nameStartsWith);

}

class DioDataSource implements RemoteDataSource {
  final MarvelApiClient marvelClient;
  final String ts = '2';
  final String apiKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';
  final String nameStartWith = 'n';

  DioDataSource({required this.marvelClient});

  @override
  Future<HttpResponse<ApiResponseModel>> getCharacters(int offset) async {
    return await marvelClient.getCharacters(ts, apiKey, hash, offset);
  }

  @override
  Future<HttpResponse<ApiResponseModel>> getCharacterDetails(int characterId) async {
    return await marvelClient.getCharacterDetails(characterId, ts, apiKey, hash);
  }

  @override
  Future<HttpResponse<SeriesResponseModel>> getAllSeries(int characterId) async {
    return await marvelClient.getAllSeries(characterId, ts, apiKey, hash);
  }

  @override
  Future<HttpResponse<ApiResponseModel>> searchCharacters(String nameStartsWith) async{
    print('asdgfadgfasfd');
    return await marvelClient.searchCharacters(nameStartsWith, ts, apiKey, hash);
  }
}
