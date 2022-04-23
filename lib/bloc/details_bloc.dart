import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/marvel_event.dart';
import 'package:marvel/bloc/marvel_state.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

class DetailsBloc extends Bloc<MarvelEvent, MarvelState> {
  final MarvelRepository marvelRepository;

  DetailsBloc(this.marvelRepository)
      : super(DetailsLoadedState(loadedAllSeries: [])) {
    on<DetailsLoadEvent>(
      (event, emit) async {
        emit(DataLoadingState());
        try {
          final List<Series> _loadedDetailList =
              await marvelRepository.getAllSeries(event.characterId);
          emit(DetailsLoadedState(loadedAllSeries: _loadedDetailList));
        } catch (e) {
          emit(MarvellErrorState());
        }
      },
    );
  }
}
