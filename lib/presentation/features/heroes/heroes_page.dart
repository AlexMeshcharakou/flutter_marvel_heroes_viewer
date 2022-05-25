import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/repository/repository_impl.dart';
import 'package:marvel/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/widgets/list_characters.dart';

class HeroesPage extends StatelessWidget {
  final GetCharactersUseCase getAllCharactersUseCase = GetCharactersUseCase(marvelRepository: RepositoryImpl());

  HeroesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Marvel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocProvider<HeroesBloc>(
        create: (context) => HeroesBloc(getCharactersUseCase: getAllCharactersUseCase)..add(HeroesEvent()),
        child: ListCharacters(),
      ),
    );
  }
}
