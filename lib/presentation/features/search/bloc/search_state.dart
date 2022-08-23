import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';

@immutable
class SearchState extends Equatable {
  final bool loading;
  final bool hasReachedMax;
  final List<CharacterViewData>? charactersViewData;
  final String? error;

  const SearchState({required this.loading, this.charactersViewData, this.error, required this.hasReachedMax});

  SearchState copyWith({loading, hasReachedMax, characters, error}) => SearchState(
      loading: loading ?? this.loading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      charactersViewData: characters ?? charactersViewData,
      error: error ?? this.error);

  @override
  List<Object?> get props => [loading, hasReachedMax, charactersViewData, error];
}
