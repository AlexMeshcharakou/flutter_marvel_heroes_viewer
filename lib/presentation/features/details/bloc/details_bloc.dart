import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:marvel/data/repository/repository.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';

import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Repository marvelRepository;

  DetailsBloc(this.marvelRepository)
      : super(
          const DetailsState(loading: true),
        ) {
    on<DetailsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          // final Character character = await marvelRepository.fetchCharacters(event.characterId);
          // final List<Series> series = await marvelRepository.getAllSeries(event.characterId);
          // emit(
          //   state.copyWith(character: character, allSeries: series, loading: false),
          // );
        } catch (e) {
          emit(
            state.copyWith(
              loading: false,
              error: "error",
            ),
          );
        }
      },
    );
  }
}
