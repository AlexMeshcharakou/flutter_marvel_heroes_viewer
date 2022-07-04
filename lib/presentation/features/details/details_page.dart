import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/widgets/details_widget.dart';

class DetailsPage extends StatelessWidget {
  final int characterId;
  final String name;
  final String url;

  const DetailsPage({Key? key, required this.characterId, required this.name, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DetailsBloc>(
        create: (context) => DetailsBloc(context: context)
          ..add(
            DetailsEvent(characterId),
          ),
        child: DetailsWidget(
          characterId: characterId,
          name: name,
          url: url,
        ),
      ),
    );
  }
}
