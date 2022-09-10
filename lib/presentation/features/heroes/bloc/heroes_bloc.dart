import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/converters/converter.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final GetCharactersUseCase getCharactersUseCase;

  HeroesBloc({required this.getCharactersUseCase})
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
          if (charactersViewData.isEmpty) {
            emit(state.copyWith(loading: false, error: DataRetrievingException()));
            return;
          }
          emit(
            state.copyWith(loading: false, characters: charactersViewData),
          );
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
  }

  List<CharacterViewData> _mapCharacters(List<Character> characters) {
    return characters
        .map(
          (characterEntity) => characterEntity.charactersToViewData(characterEntity),
        )
        .toList();
  }
}
