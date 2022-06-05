import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/presentation/view_models/view_data_character.dart';

@immutable
class HeroesState extends Equatable {
  final bool loading;
  final bool hasReachedMax;
  final List<ViewDataCharacter>? charactersViewData;
  final bool error;

  const HeroesState({required this.loading, required this.hasReachedMax, this.charactersViewData, required this.error});

  HeroesState copyWith({loading, hasReachedMax, characters, error}) => HeroesState(
      loading: loading ?? this.loading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      charactersViewData: characters ?? charactersViewData,
      error: error ?? this.error);

  @override
  List<Object?> get props => [loading, hasReachedMax, charactersViewData, error];
}
