import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/heroes_bloc.dart';
import 'package:marvel/bloc/marvel_event.dart';
import 'package:marvel/data/repository/marvel_repository.dart';
import 'package:marvel/widgets/list_characters.dart';

class HeroesPage extends StatelessWidget {
  final marvelRepository = MarvelRepository();

  HeroesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HeroesBloc>(
      create: (context) =>
          HeroesBloc(marvelRepository)..add(CharactersLoadEvent()),
      child: Scaffold(
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
        body: const ListCharacters(),
      ),
    );
  }
}
