import 'package:flutter/cupertino.dart';
import 'package:marvel/data/model/character.dart';
import 'package:equatable/equatable.dart';

@immutable
class HeroesPageState extends Equatable {
  final bool loading;
  final List<Character>? characters;
  final String? error;

  const HeroesPageState({required this.loading, this.characters, this.error});

  HeroesPageState copyWith({loading, characters, error}) => HeroesPageState(
      loading: loading ?? this.loading, characters: characters ?? this.characters, error: error ?? this.error);

  @override
  List<Object?> get props => [loading, characters, error];
}
