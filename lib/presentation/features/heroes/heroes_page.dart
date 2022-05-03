import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/repository/marvel_repository.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/widgets/list_characters.dart';

class HeroesPage extends StatelessWidget {
  final marvelRepository = MarvelRepository();

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
        create: (context) => HeroesBloc(marvelRepository)..add(HeroesEvent()),
        child: const ListCharacters(),
      ),
    );
  }
}
