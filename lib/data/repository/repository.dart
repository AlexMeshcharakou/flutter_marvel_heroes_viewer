import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';

abstract class Repository {
  Future<List<Character>> fetchCharacters();

  Future<Character> fetchCharacterDetails(int characterId);

  Future<List<Series>> fetchSeries(int characterId);
}
