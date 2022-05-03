import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';

@immutable
class DetailsState extends Equatable {
  final bool loading;
  final Character? character;
  final List<Series>? allSeries;
  final String? error;

  const DetailsState({required this.loading, this.character, this.allSeries, this.error});

  DetailsState copyWith({required loading, character, allSeries, error}) => DetailsState(
        loading: loading ?? this.loading,
        character: character ?? this.character,
        allSeries: allSeries ?? this.allSeries,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [loading, character, allSeries, error];
}
