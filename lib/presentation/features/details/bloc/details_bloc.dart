import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:marvel/data/repository/repository_impl.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/use_cases/get_character_details_use_case.dart';
import 'package:marvel/domain/use_cases/get_series_use_case.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';

import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCharacterDetailsUseCase getCharacterDetails;
  final GetAllSeriesUseCase getAllSeries;

  DetailsBloc({required this.getAllSeries, required this.getCharacterDetails})
      : super(
          const DetailsState(loading: true),
        ) {
    on<DetailsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final Character character = await getCharacterDetails.call(event.characterId);
          final List<Series> series = await getAllSeries(event.characterId);
          emit(
            state.copyWith(character: character, allSeries: series, loading: false),
          );
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
