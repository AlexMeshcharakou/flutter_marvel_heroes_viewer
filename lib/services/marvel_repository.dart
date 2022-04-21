import 'package:marvel/services/marvel_api_provider.dart';

import '../model/character.dart';
import '../model/series.dart';

class MarvelRepository {
  final MarvelApiProvider _marvelApiProvider = MarvelApiProvider();
  late int characterId;
  Future<List<Character>> getAllCharacters() => _marvelApiProvider.getCharacters();

  Future<List<Series>> getAllSeries(characterId) => _marvelApiProvider.getSeries (characterId);
}