import 'package:domain/domain_module.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_state.dart';
import 'package:marvel/presentation/view_data/character_view_data.dart';
import 'package:mocktail/mocktail.dart';

class MockMarvelRepository extends Mock implements MarvelRepository {}

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

const mockCharacters = <CharacterViewData>[];

void main() {
  late GetCharactersUseCase getCharactersUseCase;
  late HeroesBloc heroesBloc;
  setUp(() {
    getCharactersUseCase = MockGetCharactersUseCase();
    heroesBloc = HeroesBloc(getCharactersUseCase: getCharactersUseCase);
  });
  blocTest(
    'emits [HeroesState(loading: true, hasReachedMax: false), '
    'HeroesState(loading: false, hasReachedMax: false, charactersViewData: mockCharacters)] when successful',
    build: () => heroesBloc,
    act: (bloc) => bloc!.add(ReadyForDataEvent()),
    expect: () => [
      const HeroesState(loading: true, hasReachedMax: false),
      const HeroesState(loading: false, hasReachedMax: false, charactersViewData: mockCharacters)
    ],
  );
}
