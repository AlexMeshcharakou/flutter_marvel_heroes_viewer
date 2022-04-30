import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/data/model/series.dart';

@immutable
class DetailsState extends Equatable {
  final bool loading;
  final List<Series>? allSeries;
  final String? error;

  const DetailsState({required this.loading, this.allSeries, this.error});

  DetailsState copyWith({loading, allSeries, error}) =>
      DetailsState(loading: loading ?? this.loading, allSeries: allSeries ?? this.allSeries, error: error ?? this.error);

  @override
  List<Object?> get props => [loading, allSeries, error];
}
