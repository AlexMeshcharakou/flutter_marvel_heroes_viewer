import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/marvel_bloc.dart';
import 'package:marvel/data/repository/marvel_repository.dart';
import 'package:marvel/widgets/details_widget.dart';


class DetailsPage extends StatelessWidget {
  final marvelRepository = MarvelRepository();

  DetailsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider<MarvelBloc>(
      create: (context) => MarvelBloc(marvelRepository),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Second',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ), body: const DetailsWidget(),
      ),
    );
  }
}
