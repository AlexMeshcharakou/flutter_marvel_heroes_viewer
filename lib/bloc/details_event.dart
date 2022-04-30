import 'package:equatable/equatable.dart';

class DetailsEvent extends Equatable {
  final int characterId;

  const DetailsEvent(this.characterId);

  @override
  List<Object?> get props => [characterId];
}
