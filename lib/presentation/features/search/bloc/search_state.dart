import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';

@immutable
class SearchState extends Equatable {
  final bool loading;
  final bool hasReachedMax;
  final List<CharacterViewData>? charactersViewData;
  final String? error;
  final bool? noResult;
  final bool? afterScroll;
  final bool? emptySearchField;

  const SearchState(
      {required this.loading,
      required this.hasReachedMax,
      this.charactersViewData,
      this.noResult,
      this.error,
      this.afterScroll,
      this.emptySearchField});

  SearchState copyWith({loading, hasReachedMax, charactersViewData, error, noResult, afterScroll, emptySearchField}) =>
      SearchState(
          loading: loading ?? this.loading,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          charactersViewData: charactersViewData ?? this.charactersViewData,
          error: error ?? this.error,
          noResult: noResult ?? this.noResult,
          afterScroll: afterScroll ?? this.afterScroll,
          emptySearchField: emptySearchField ?? this.emptySearchField);

  @override
  List<Object?> get props =>
      [loading, hasReachedMax, charactersViewData, error, noResult, afterScroll, emptySearchField];
}
