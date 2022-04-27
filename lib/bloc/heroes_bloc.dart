import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/heroes_page_event.dart';
import 'package:marvel/bloc/heroes_page_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

class HeroesBloc extends Bloc<HeroesPageEvent, HeroesPageState> {
  final MarvelRepository marvelRepository;

  HeroesBloc(this.marvelRepository)
      : super(const HeroesPageState(loading: true)) {
    on<HeroesPageEvent>(
      (event, emit) async {
        emit(state.copyWith(loading: true));
        try {
          final List<Character> _loadedCharacterList =
              await marvelRepository.getAllCharacters();
          emit(state.copyWith(loading: false, characters: _loadedCharacterList, ));
        } catch (e) {
          emit(state.copyWith(error: "error", loading: false));
        }
      },
    );
  }
}
