import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_page_state.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

import 'details_page_event.dart';

class DetailsBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  final MarvelRepository marvelRepository;

  DetailsBloc(this.marvelRepository) : super(const DetailsPageState(loading: true)) {
    on<DetailsPageEvent>(
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
