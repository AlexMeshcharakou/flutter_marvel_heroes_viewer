import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';

abstract class MarvelRepository {
  Future<List<Character>> getCharacters();

  Future<Character> getCharacterDetails(int characterId);

  Future<List<Series>> getAllSeries(int characterId);
}
