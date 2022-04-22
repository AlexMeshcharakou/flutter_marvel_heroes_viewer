import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';

abstract class MarvelState  {}

class DataLoadingState extends MarvelState {}

class CharactersLoadedState extends MarvelState {
  final List<Character> loadedCharacters;

  CharactersLoadedState({required this.loadedCharacters});
}

class MarvellErrorState extends MarvelState {}

class DetailsLoadedState extends MarvelState {
  final List<Series> loadedAllSeries;

  DetailsLoadedState({required this.loadedAllSeries});
}
