import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchedCharacterEvent extends SearchEvent {
  final String nameStartsWith;

  SearchedCharacterEvent(this.nameStartsWith);
}
