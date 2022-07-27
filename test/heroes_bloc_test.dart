import 'package:domain/domain_module.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

void main() {
  final testCharacters = Future.value(<Character>[]);
  late GetCharactersUseCase getCharactersUseCase;
  late HeroesBloc heroesBloc;

  blocTest<HeroesBloc, HeroesState>(
    'emits [HeroesState(loading: true, hasReachedMax: false), '
    'HeroesState(loading: false, hasReachedMax: false, charactersViewData: <CharacterViewData>[])] when successful',
    setUp: () {
      getCharactersUseCase = MockGetCharactersUseCase();
      heroesBloc = HeroesBloc(getCharactersUseCase: getCharactersUseCase);
      when(() => getCharactersUseCase.call()).thenAnswer((_) => testCharacters);
    },
    build: () => heroesBloc,
    act: (bloc) => bloc
      ..add(ReadyForDataEvent())
      ..add(ScrolledToEndEvent()),
    expect: () => [
      const HeroesState(loading: true, hasReachedMax: false),
      const HeroesState(loading: false, hasReachedMax: false, charactersViewData: <CharacterViewData>[]),
      const HeroesState(loading: true, hasReachedMax: false, charactersViewData: <CharacterViewData>[]),
      const HeroesState(loading: false, hasReachedMax: true, charactersViewData: <CharacterViewData>[])
    ],
  );
  blocTest<HeroesBloc, HeroesState>(
    'emits [HeroesState(loading: true, error: "Check internet connection", hasReachedMax: false',
    setUp: () {
      getCharactersUseCase = MockGetCharactersUseCase();
      heroesBloc = HeroesBloc(getCharactersUseCase: getCharactersUseCase);
      when(() => getCharactersUseCase.call()).thenThrow(NoInternetException());
    },
    build: () => heroesBloc,
    act: (bloc) => bloc.add(ReadyForDataEvent()),
    expect: () => [
      const HeroesState(loading: false, error: "Check internet connection", hasReachedMax: false),
    ],
  );
}
