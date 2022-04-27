import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/heroes_event.dart';
import 'package:marvel/bloc/heroes_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final MarvelRepository marvelRepository;

  HeroesBloc(this.marvelRepository)
      : super(CharactersLoadedState(characters: [])) {
    on<LoadCharactersEvent>(
      (event, emit) async {
        emit(DataLoadingState());
        try {
          final List<Character> _loadedCharacterList =
              await marvelRepository.getAllCharacters();
          emit(CharactersLoadedState(characters: _loadedCharacterList));
        } catch (e) {
          emit(HeroesErrorState());
        }
      },
    );
  }
}
