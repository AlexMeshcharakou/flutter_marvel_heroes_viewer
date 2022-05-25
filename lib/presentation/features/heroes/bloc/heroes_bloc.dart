import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/domain/entities/character.dart';
import 'package:marvel/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/convertors/convertor.dart';
import 'package:marvel/presentation/view_models/view_data_character.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final GetCharactersUseCase getCharactersUseCase;
  int offset = 0;
  bool isFetching = false;

  HeroesBloc({required this.getCharactersUseCase})
      : super(
          const HeroesState(loading: true),
        ) {
    on<HeroesEvent>(
      (event, emit) async {
        try {
          if (state.charactersViewData == null) {
            final List<Character> characters = await getCharactersUseCase.call(offset);
            final List<ViewDataCharacter> charactersViewData = characters
                .map(
                  (characterEntity) => characterEntity.charactersToViewData(characterEntity),
                )
                .toList();
            isFetching = false;
            emit(
              state.copyWith(
                loading: false,
                characters: charactersViewData,
              ),
            );
          } else {
            final List<Character> characters = await getCharactersUseCase.call(state.charactersViewData!.length);
            final List<ViewDataCharacter> charactersViewData = characters
                .map(
                  (characterEntity) => characterEntity.charactersToViewData(characterEntity),
                )
                .toList();
            isFetching = false;
            emit(
              state.copyWith(
                loading: false,
                characters: state.charactersViewData! + charactersViewData,
              ),
            );
          }
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
