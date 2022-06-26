import 'package:marvel/data/data_sources/marvel_api_client.dart';
import 'package:marvel/data/models/remote_models/character_model.dart';
import 'package:marvel/data/models/remote_models/series_model.dart';
import 'package:marvel/main.dart';
import 'package:retrofit/retrofit.dart';

abstract class RemoteDataSource {
  Future<HttpResponse<ApiResponseModel>> getCharacters(int offset);

  Future<HttpResponse<ApiResponseModel>> getCharacterDetails(int characterId);

  Future<HttpResponse<SeriesResponseModel>> getAllSeries(int characterId);
}

class DioDataSource implements RemoteDataSource {
  final MarvelApiClient marvelClient = getIt.get<MarvelApiClient>();
  final String ts = '2';
  final String apiKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

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
}
