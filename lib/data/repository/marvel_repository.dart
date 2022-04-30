import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_api_client.dart';

class MarvelRepository {
  final MarvelApiClient _marvelApiClient = MarvelApiClient();
  late int characterId;

  Future<List<Character>> getAllCharacters() =>
      _marvelApiClient.getCharacters();

  Future<List<Series>> getAllSeries(characterId) =>
      _marvelApiClient.getSeries(characterId);
}
