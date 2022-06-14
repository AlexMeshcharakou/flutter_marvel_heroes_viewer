import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/repository/default_repository.dart';
import 'package:marvel/domain/use_cases/get_character_details_use_case.dart';
import 'package:marvel/domain/use_cases/get_series_use_case.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/widgets/details_widget.dart';

class DetailsPage extends StatelessWidget {
  final GetCharacterDetailsUseCase getCharacterDetailsUseCase =
      GetCharacterDetailsUseCase(marvelRepository: DefaultRepository(dioDataSource: DioDataSource()));
  final GetAllSeriesUseCase getAllSeriesUseCase =
      GetAllSeriesUseCase(marvelRepository: DefaultRepository(dioDataSource: DioDataSource()));
  final int characterId;

  DetailsPage({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DetailsBloc>(
          create: (context) =>
              DetailsBloc(getCharacterDetails: getCharacterDetailsUseCase, getAllSeries: getAllSeriesUseCase)
                ..add(DetailsEvent(characterId)),
          child: DetailsWidget(characterId)),
    );
  }
}
