import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class ReadyForDetailsEvent extends DetailsEvent {
  final int characterId;

  ReadyForDetailsEvent(this.characterId);
}