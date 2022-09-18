import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/view_data/details_view_data.dart';
import 'package:marvel/presentation/view_data/series_view_data.dart';

import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCharacterDetailsUseCase getCharacterDetailsUseCase;
  final GetAllSeriesUseCase getAllSeriesUseCase;

  DetailsBloc({required this.getCharacterDetailsUseCase, required this.getAllSeriesUseCase})
      : super(
          const DetailsState(loading: true),
        ) {
    on<ReadyForDetailsEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final Character character = await getCharacterDetailsUseCase(event.characterId);
          final DetailsViewData characterDetails = character.detailsToViewData(character);
          final List<Series> allSeries = await getAllSeriesUseCase(event.characterId);
          final List<SeriesViewData> series = allSeries
              .map(
                (seriesResponse) => seriesResponse.seriesToViewData(seriesResponse),
              )
              .cast<SeriesViewData>()
              .toList();
          emit(
            state.copyWith(loading: false, characterDetails: characterDetails, series: series),
          );
        } on DataRetrievingException catch (exception) {
          emit(
            state.copyWith(loading: false, error: exception),
          );
        } on NoInternetException catch (exception) {
          emit(
            state.copyWith(loading: false, error: exception),
          );
        }
      },
    );
  }
}
