import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/widgets/details_widget.dart';
import 'package:marvel/service_locator.dart';
import 'package:domain/domain_module.dart';

class DetailsPage extends StatelessWidget {
  final int characterId;

  const DetailsPage({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DetailsBloc>(
        create: (context) => DetailsBloc(
          context: context,
          getCharacterDetailsUseCase: getIt.get<GetCharacterDetailsUseCase>(),
          getAllSeriesUseCase: getIt.get<GetAllSeriesUseCase>(),
        )..add(
            DetailsEvent(characterId),
          ),
        child: DetailsWidget(characterId),
      ),
    );
  }
}
