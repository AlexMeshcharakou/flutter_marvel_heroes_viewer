import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/exceptions/exceptions.dart';
import 'package:marvel/domain/use_cases/get_character_details_use_case.dart';
import 'package:marvel/domain/use_cases/get_series_use_case.dart';
import 'package:marvel/main.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/view_data/view_data_details.dart';
import 'package:marvel/presentation/view_data/view_data_series.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'details_event.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCharacterDetailsUseCase getCharacterDetailsUseCase = getIt.get<GetCharacterDetailsUseCase>();
  final GetAllSeriesUseCase getAllSeriesUseCase = getIt.get<GetAllSeriesUseCase>();
  final BuildContext context;

  DetailsBloc({required this.context})
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
          final ViewDataCharacterDetails characterDetails = character.detailsToViewData(character);
          final List<Series> allSeries = await getAllSeriesUseCase(event.characterId);
          final List<ViewDataSeries> series = allSeries
              .map(
                (seriesResponse) => seriesResponse.seriesToViewData(seriesResponse),
              )
              .cast<ViewDataSeries>()
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
