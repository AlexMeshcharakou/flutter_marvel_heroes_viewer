import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_api_client.dart';

class MarvelRepository {
  final MarvelApiClient _marvelApiProvider = MarvelApiClient();
  late int characterId;

  Future<List<Character>> getAllCharacters() =>
      _marvelApiProvider.getCharacters();

  Future<List<Series>> getAllSeries(characterId) =>
      _marvelApiProvider.getSeries(characterId);
}
