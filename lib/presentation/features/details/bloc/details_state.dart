import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/presentation/view_data/details_view_data.dart';
import 'package:marvel/presentation/view_data/series_view_data.dart';

@immutable
class DetailsState extends Equatable {
  final bool loading;
  final DetailsViewData? characterDetails;
  final List<SeriesViewData>? series;
  final Exception? error;

  const DetailsState({required this.loading, this.characterDetails, this.series, this.error});

  DetailsState copyWith(
          {bool? loading, DetailsViewData? characterDetails, List<SeriesViewData>? series, Exception? error}) =>
      DetailsState(
        loading: loading ?? this.loading,
        characterDetails: characterDetails ?? this.characterDetails,
        series: series ?? this.series,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [loading, characterDetails, series, error];
}
