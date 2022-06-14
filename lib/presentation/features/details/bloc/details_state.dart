import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/presentation/view_data/view_data_details.dart';
import 'package:marvel/presentation/view_data/view_data_series.dart';

@immutable
class DetailsState extends Equatable {
  final bool loading;
  final ViewDataCharacterDetails? characterDetails;
  final List<ViewDataSeries>? series;
  final bool error;

  const DetailsState({required this.loading, this.characterDetails, this.series, required this.error});

  DetailsState copyWith({required loading, characterDetails, series, error}) => DetailsState(
        loading: loading ?? this.loading,
        characterDetails: characterDetails ?? this.characterDetails,
        series: series ?? this.series,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [loading, characterDetails, series, error];
}
