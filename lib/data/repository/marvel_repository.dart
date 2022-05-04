import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:marvel/data/repository/marvel_api_client.dart';

class MarvelRepository {
  final MarvelApiClient _marvelApiClient = MarvelApiClient();

  Future<List<Character>> getAllCharacters() => _marvelApiClient.getCharacters();

  Future<Character> getCharacter(characterId) => _marvelApiClient.getCharacter(characterId);

  Future<List<Series>> getAllSeries(characterId) => _marvelApiClient.getSeries(characterId);
}
