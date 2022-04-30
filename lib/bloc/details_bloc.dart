import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_state.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final MarvelRepository marvelRepository;

  DetailsBloc(this.marvelRepository) : super(const DetailsState(loading: true)) {
    on<DetailsEvent>(
      (event, emit) async {
        emit(state.copyWith(loading: true));
        try {
          final List<Series> _loadedDetailList = await marvelRepository.getAllSeries(event.characterId);
          emit(state.copyWith(allSeries: _loadedDetailList, loading: false));
        } catch (e) {
          emit(state.copyWith(error: "error", loading: false));
        }
      },
    );
  }
}
