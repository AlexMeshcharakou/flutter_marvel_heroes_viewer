import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/view_data/view_data_character.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final GetCharactersUseCase getCharactersUseCase;

  HeroesBloc({required this.getCharactersUseCase})
      : super(
          const HeroesState(loading: false, hasReachedMax: false, error: false),
        ) {
    on<ReadyForDataEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final List<Character> characters = await getCharactersUseCase();
          final List<ViewDataCharacter> charactersViewData = _mapCharacters(characters);
          emit(
            state.copyWith(loading: false, characters: charactersViewData),
          );
        } catch (ex) {
          emit(
            state.copyWith(loading: false, error: true),
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
          final List<Character> characters = await getCharactersUseCase.call(state.charactersViewData!.length);
          if (characters.isEmpty) {
            emit(state.copyWith(loading: false, hasReachedMax: true));
            return;
          }
          final List<ViewDataCharacter> charactersViewData = _mapCharacters(characters);
          emit(
            state.copyWith(loading: false, characters: state.charactersViewData! + charactersViewData),
          );
        } catch (ex) {
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

  List<ViewDataCharacter> _mapCharacters(List<Character> characters) {
    return characters
        .map(
          (characterEntity) => characterEntity.charactersToViewData(characterEntity),
        )
        .toList();
  }
}
