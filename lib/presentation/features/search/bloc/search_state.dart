import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';

@immutable
class SearchState extends Equatable {
  final bool loading;
  final bool hasReachedMax;
  final List<CharacterViewData>? charactersViewData;
  final bool? afterScroll;
  final bool? emptySearchField;
  final Exception? error;
  final bool? noResult;

  const SearchState(
      {required this.loading,
      required this.hasReachedMax,
      this.charactersViewData,
      this.afterScroll,
      this.emptySearchField,
      this.error,
      this.noResult});

  SearchState copyWith(
          {bool? loading,
          bool? hasReachedMax,
          List<CharacterViewData>? charactersViewData,
          bool? afterScroll,
          bool? emptySearchField,
          Exception? error,
          bool? noResult}) =>
      SearchState(
          loading: loading ?? this.loading,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          charactersViewData: charactersViewData ?? this.charactersViewData,
          afterScroll: afterScroll ?? this.afterScroll,
          emptySearchField: emptySearchField ?? this.emptySearchField,
          error: error ?? this.error,
          noResult: noResult ?? this.noResult);

  @override
  List<Object?> get props =>
      [loading, hasReachedMax, charactersViewData, afterScroll, emptySearchField, error, noResult];
}
