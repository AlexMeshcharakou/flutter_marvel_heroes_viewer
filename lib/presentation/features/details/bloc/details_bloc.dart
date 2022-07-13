import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/exceptions/exceptions.dart';
import 'package:marvel/domain/use_cases/get_character_details_use_case.dart';
import 'package:marvel/domain/use_cases/get_series_use_case.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/view_data/details_view_data.dart';
import 'package:marvel/presentation/view_data/series_view_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCharacterDetailsUseCase getCharacterDetailsUseCase;
  final GetAllSeriesUseCase getAllSeriesUseCase;
  final BuildContext context;

  DetailsBloc({required this.getCharacterDetailsUseCase, required this.getAllSeriesUseCase, required this.context})
      : super(
          const DetailsState(loading: true),
        ) {
    on<DetailsEvent>(
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
            state.copyWith(characterDetails: characterDetails, series: series, loading: false),
          );
        } on DataRetrievingException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.somethingWentWrong),
          );
        } on NoInternetException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.checkInternetConnectionAndTap),
          );
        }
      },
    );
  }
}
