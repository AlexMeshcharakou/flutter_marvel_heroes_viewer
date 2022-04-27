import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/data/model/series.dart';

@immutable
class DetailsPageState extends Equatable {
  final bool loading;
  final List<Series>? allSeries;
  final String? error;

  const DetailsPageState({required this.loading, this.allSeries, this.error});

  DetailsPageState copyWith({loading, allSeries, error}) =>
      DetailsPageState(loading: loading ?? this.loading, allSeries: allSeries ?? this.allSeries, error: error ?? this.error);

  @override
  List<Object?> get props => [loading, allSeries, error];
}
