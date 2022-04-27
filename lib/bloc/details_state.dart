import 'package:marvel/data/model/series.dart';

abstract class DetailsState {}

class DataLoadingState extends DetailsState {}

class DetailsErrorState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  final List<Series> loadedAllSeries;

  DetailsLoadedState({required this.loadedAllSeries});
}
