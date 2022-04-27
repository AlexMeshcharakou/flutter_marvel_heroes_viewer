import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_event.dart';
import 'package:marvel/bloc/details_state.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final MarvelRepository marvelRepository;

  DetailsBloc(this.marvelRepository) : super(DetailsLoadedState(loadedAllSeries: [])) {
    on<LoadDetailsEvent>(
      (event, emit) async {
        emit(DataLoadingState());
        try {
          final List<Series> _loadedDetailList = await marvelRepository.getAllSeries(event.characterId);
          emit(DetailsLoadedState(loadedAllSeries: _loadedDetailList));
        } catch (e) {
          emit(DetailsErrorState());
        }
      },
    );
  }
}
