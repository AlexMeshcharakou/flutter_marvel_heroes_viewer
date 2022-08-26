import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GotEmptySearchField extends SearchEvent {}

class SearchedCharacterEvent extends SearchEvent {
  final String nameStartsWith;

  SearchedCharacterEvent({required this.nameStartsWith});
}

class ScrolledToEndSearchEvent extends SearchEvent {
  final String nameStartsWith;

  ScrolledToEndSearchEvent({required this.nameStartsWith});
}
