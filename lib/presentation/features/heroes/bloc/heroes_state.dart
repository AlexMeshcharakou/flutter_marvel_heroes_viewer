import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';

@immutable
class HeroesState extends Equatable {
  final bool loading;
  final bool hasReachedMax;
  final List<CharacterViewData>? charactersViewData;
  final Exception? error;

  const HeroesState({required this.loading, required this.hasReachedMax, this.charactersViewData, this.error});

  HeroesState copyWith({bool? loading, bool? hasReachedMax, List<CharacterViewData>? characters, Exception? error}) =>
      HeroesState(
          loading: loading ?? this.loading,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          charactersViewData: characters ?? charactersViewData,
          error: error ?? this.error);

  @override
  List<Object?> get props => [loading, hasReachedMax, charactersViewData, error];
}
