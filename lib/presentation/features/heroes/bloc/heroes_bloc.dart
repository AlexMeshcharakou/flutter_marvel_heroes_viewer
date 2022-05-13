import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final GetCharactersUseCase getCharacters;

  HeroesBloc({required this.getCharacters})
      : super(
          const HeroesState(loading: true),
        ) {
    on<HeroesEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final List<Character> characters = await getCharacters.call();
          emit(
            state.copyWith(
              loading: false,
              characters: characters,
            ),
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
