import 'package:marvel/data/models/character.dart';

abstract class Repository {
  Future<List<Character>> fetchCharacters();
}
