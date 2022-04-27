abstract class DetailsEvent {}

class LoadDetailsEvent extends DetailsEvent {
  final int characterId;

  LoadDetailsEvent(this.characterId);
}
