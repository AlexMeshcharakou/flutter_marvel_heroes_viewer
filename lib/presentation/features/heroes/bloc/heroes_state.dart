import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/presentation/view_models/view_data_character.dart';

@immutable
class HeroesState extends Equatable {
  final bool loading;
  final List<ViewDataCharacter>? charactersViewData;
  final String? error;

  const HeroesState({required this.loading, this.charactersViewData, this.error});

  HeroesState copyWith({loading, characters, error}) => HeroesState(
      loading: loading ?? this.loading,
      charactersViewData: characters ?? charactersViewData,
      error: error ?? this.error);

  @override
  List<Object?> get props => [loading, charactersViewData, error];
}
