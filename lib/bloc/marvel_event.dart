abstract class MarvelEvent {}

class CharactersLoadEvent extends MarvelEvent {}

class DetailsLoadEvent extends MarvelEvent {
  final int characterId;

  DetailsLoadEvent(this.characterId);
}
