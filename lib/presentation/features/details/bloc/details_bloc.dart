import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/use_cases/get_character_details_use_case.dart';
import 'package:marvel/domain/use_cases/get_series_use_case.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/view_data/view_data_details.dart';
import 'package:marvel/presentation/view_data/view_data_series.dart';

import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCharacterDetailsUseCase getCharacterDetailsUseCase;
  final GetAllSeriesUseCase getAllSeriesUseCase;

  DetailsBloc({required this.getAllSeriesUseCase, required this.getCharacterDetailsUseCase})
      : super(
          const DetailsState(loading: true, error: false),
        ) {
    on<DetailsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final Character character = await getCharacterDetailsUseCase(event.characterId);
          final ViewDataCharacterDetails characterDetails = character.detailsToViewData(character);
          final List<Series> allSeries = await getAllSeriesUseCase(event.characterId);
          final List<ViewDataSeries> series = allSeries
              .map(
                (seriesResponse) => seriesResponse.seriesToViewData(seriesResponse),
              ).cast<ViewDataSeries>()
              .toList();
          emit(
            state.copyWith(characterDetails: characterDetails, series: series, loading: false),
          );
        } catch (e) {
          emit(
            state.copyWith(
              loading: false,
              error: true,
            ),
          );
        }
      },
    );
  }
}
