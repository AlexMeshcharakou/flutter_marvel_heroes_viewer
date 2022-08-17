import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/bloc/search_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:domain/domain_module.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCharactersUseCase searchCharactersUseCase;
  final BuildContext? context;

  SearchBloc({required this.searchCharactersUseCase, this.context})
      : super(
          const SearchState(loading: false),
        ) {
    on<SearchedCharacterEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final List<Character> characters = await searchCharactersUseCase('n');
          final List<CharacterViewData> charactersViewData = _mapCharacters(characters);
          emit(
            state.copyWith(loading: false, characters: charactersViewData),
          );
        } on DataRetrievingException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context!)!.somethingWentWrong),
          );
        } on NoInternetException {
          emit(
            state.copyWith(loading: false, error: AppLocalizations.of(context!)!.pleaseCheckInternetConnection),
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
