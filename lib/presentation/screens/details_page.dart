import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_bloc.dart';
import 'package:marvel/bloc/details_event.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/repository/marvel_repository.dart';
import 'package:marvel/presentation/widgets/details_widget.dart';

class DetailsPage extends StatelessWidget {
  final marvelRepository = MarvelRepository();
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  DetailsPage({Key? key, required this.id, required this.name, required this.description, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (context) => DetailsBloc(marvelRepository)..add(DetailsEvent(id)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: DetailsWidget(
          description: description,
          thumbnail: thumbnail,
        ),
      ),
    );
  }
}
