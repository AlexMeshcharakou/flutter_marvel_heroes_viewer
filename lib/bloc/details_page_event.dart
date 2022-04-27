import 'package:equatable/equatable.dart';

class DetailsPageEvent extends Equatable {
  final int characterId;

  const DetailsPageEvent(this.characterId);

  @override
  List<Object?> get props => [characterId];
}
