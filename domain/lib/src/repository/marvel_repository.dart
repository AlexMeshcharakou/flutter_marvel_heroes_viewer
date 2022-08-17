import 'package:domain/domain_module.dart';

abstract class MarvelRepository {
  Future<List<Character>> getCharacters(int offset);

  Future<Character> getCharacterDetails(int characterId);

  Future<List<Series>> getAllSeries(int characterId);

  Future<List<Character>> searchCharacters(String nameStartsWith);
}
