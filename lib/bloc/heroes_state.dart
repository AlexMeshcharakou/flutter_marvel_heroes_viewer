import 'package:marvel/data/model/character.dart';

abstract class HeroesState {}

class DataLoadingState extends HeroesState {}

class HeroesErrorState extends HeroesState {}

class CharactersLoadedState extends HeroesState {
  final List<Character> characters;

  CharactersLoadedState({required this.characters});
}
