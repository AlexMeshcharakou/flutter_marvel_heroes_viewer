import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:domain/domain_module.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final GetCharactersUseCase getCharactersUseCase;
  final BuildContext context;

  HeroesBloc({required this.getCharactersUseCase, required this.context})
      : super(
          const HeroesState(loading: false, hasReachedMax: false),
        ) {
    on<ReadyForDataEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final List<Character> characters = await getCharactersUseCase();
          final List<CharacterViewData> charactersViewData = _mapCharacters(characters);
          emit(
            state.copyWith(loading: false, characters: charactersViewData),
          );
        } on DataRetrievingException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.somethingWentWrong),
          );
        } on NoInternetException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.pleaseCheckInternetConnection),
          );
        }
      },
    );
    on<ScrolledToEndEvent>(
      (event, emit) async {
        if (state.loading || state.hasReachedMax) return;
        emit(
          state.copyWith(loading: true, hasReachedMax: false),
        );
        try {
          final List<Character> characters = await getCharactersUseCase(state.charactersViewData!.length);
          if (characters.isEmpty) {
            emit(state.copyWith(loading: false, hasReachedMax: true));
            return;
          }
          final List<CharacterViewData> charactersViewData = _mapCharacters(characters);
          emit(
            state.copyWith(loading: false, characters: state.charactersViewData! + charactersViewData),
          );
        } on DataRetrievingException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.somethingWentWrong),
          );
        } on NoInternetException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context)!.pleaseCheckInternetConnection),
          );
        }
      },
    );
  }

  List<CharacterViewData> _mapCharacters(List<Character> characters) {
    return characters
        .map(
          (characterEntity) => characterEntity.charactersToViewData(characterEntity),
        )
        .toList();
  }
}
