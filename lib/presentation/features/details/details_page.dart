import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/repository/marvel_repository.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/widgets/details_widget.dart';

class DetailsPage extends StatelessWidget {
  final marvelRepository = MarvelRepository();
  final int characterId;

  DetailsPage({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(marvelRepository)..add(DetailsEvent(characterId)),
          child: DetailsWidget(characterId)),
    );
  }
}
