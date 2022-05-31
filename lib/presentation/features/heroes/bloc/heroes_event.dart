import 'package:equatable/equatable.dart';

abstract class HeroesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadyForDataEvent extends HeroesEvent {}

class ScrolledToEndEvent extends HeroesEvent {}