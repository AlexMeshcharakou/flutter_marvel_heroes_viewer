import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/repository/repository.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final Repository repository;

  HeroesBloc({required this.repository})
      : super(
          const HeroesState(loading: true),
        ) {
    on<HeroesEvent>(
      (event, emit) async {
        emit(
          state.copyWith(loading: true),
        );
        try {
          final List<Character> characters = await repository.fetchCharacters();
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
