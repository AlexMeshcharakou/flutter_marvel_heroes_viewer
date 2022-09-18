import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';
import 'package:marvel/presentation/features/search/bloc/search_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:domain/domain_module.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCharactersUseCase searchCharactersUseCase;

  SearchBloc({required this.searchCharactersUseCase})
      : super(
          const SearchState(loading: false, hasReachedMax: false, afterScroll: false),
        ) {
    on<SearchedCharacterEvent>(
      (event, emit) async {
        String name = event.nameStartsWith;
        emit(
          state.copyWith(loading: true, hasReachedMax: false, emptySearchField: false),
        );
        try {
          final List<Character> characters = await searchCharactersUseCase(name);
          final List<CharacterViewData> charactersViewData = _mapCharacters(characters);
          if (characters.isEmpty) {
            emit(
              state.copyWith(loading: false, noResult: true),
            );
          }
          if (characters.length < 20 && characters.isNotEmpty) {
            emit(
              state.copyWith(loading: false, hasReachedMax: true, charactersViewData: charactersViewData),
            );
          }
          if (characters.isNotEmpty) {
            emit(
              state.copyWith(loading: false, charactersViewData: charactersViewData, noResult: false),
            );
          }
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
    on<ScrolledToEndSearchEvent>(
      (event, emit) async {
        if (state.loading || state.hasReachedMax) return;
        emit(
          state.copyWith(loading: true, hasReachedMax: false, afterScroll: true),
        );
        try {
          final List<Character> characters =
              await searchCharactersUseCase(event.nameStartsWith, state.charactersViewData!.length);
          if (characters.isEmpty) {
            emit(state.copyWith(loading: false, hasReachedMax: true));
          } else {
            final List<CharacterViewData> charactersViewData = _mapCharacters(characters);
            emit(
              state.copyWith(loading: false, charactersViewData: state.charactersViewData! + charactersViewData),
            );
          }
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
    on<GotEmptySearchField>(
      (event, emit) {
        emit(
          state.copyWith(emptySearchField: true, afterScroll: false),
        );
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
