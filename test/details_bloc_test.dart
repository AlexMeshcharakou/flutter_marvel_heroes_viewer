import 'package:domain/domain_module.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/view_data/details_view_data.dart';
import 'package:marvel/presentation/view_data/series_view_data.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharacterDetailsUseCase extends Mock implements GetCharacterDetailsUseCase {}

class MockGetAllSeriesUseCase extends Mock implements GetAllSeriesUseCase {}

void main() {
  final testCharacter = Future.value(const Character(name: '', id: 1, description: ''));
  final testSeries = Future.value(<Series>[]);
  int characterID = 1;
  late GetCharacterDetailsUseCase getCharacterDetailsUseCase;
  late GetAllSeriesUseCase getAllSeriesUseCase;
  late DetailsBloc detailsBloc;
  setUp(() {
    EquatableConfig.stringify = true;
    getCharacterDetailsUseCase = MockGetCharacterDetailsUseCase();
    getAllSeriesUseCase = MockGetAllSeriesUseCase();
    detailsBloc =
        DetailsBloc(getCharacterDetailsUseCase: getCharacterDetailsUseCase, getAllSeriesUseCase: getAllSeriesUseCase);
    when(() => getCharacterDetailsUseCase.call(characterID)).thenAnswer((_) => testCharacter);
    when(() => getAllSeriesUseCase.call(characterID)).thenAnswer((_) => testSeries);
  });
  blocTest<DetailsBloc, DetailsState>(
    'emits [DetailsState(loading: true), DetailsState(loading: false, characterDetails: DetailsViewData(description: '','
        ' ''name: '','' id: 1), series: const <SeriesViewData>[])] when successful',
    build: () => detailsBloc,
    act: (bloc) => bloc.add(ReadyForDetailsEvent(characterID)),
    expect: () => [
      const DetailsState(loading: true),
      DetailsState(
          loading: false,
          characterDetails: DetailsViewData(description: '', name: '', id: 1),
          series: const <SeriesViewData>[]),
    ],
  );
}
