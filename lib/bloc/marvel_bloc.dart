import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/marvel_event.dart';
import 'package:marvel/bloc/marvel_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';
import 'package:marvel/data/repository/marvel_repository.dart';

class MarvelBloc extends Bloc<MarvelEvent, MarvelState> {
  final MarvelRepository marvelRepository;
   // late List<Character> loadedCharacters;

  MarvelBloc(this.marvelRepository)
      : super(CharactersLoadedState(loadedCharacters: [])) {
    on<CharactersLoadEvent>(
          (event, emit) async {
        emit(DataLoadingState());
        try {
          final List<Character> _loadedCharacterList =
          await marvelRepository.getAllCharacters();
          emit(CharactersLoadedState(loadedCharacters: _loadedCharacterList));
        } catch (e) {
          emit(MarvellErrorState());
        }
      },
    );
    on<DetailsLoadEvent>(
          (event, emit) async {
        emit(DataLoadingState());
        try {
          final List<Series> _loadedDetailList =
          await marvelRepository.getAllSeries(event.characterId);
          emit(DetailsLoadedState(loadedAllSeries: _loadedDetailList));
        } catch (e) {
          emit(MarvellErrorState());
        }
      },
    );
  }
}