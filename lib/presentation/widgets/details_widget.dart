import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/widgets/build_character_image.dart';
import 'package:marvel/presentation/widgets/build_description.dart';
import 'package:marvel/presentation/widgets/build_series.dart';
import 'package:marvel/presentation/widgets/error_page.dart';

class DetailsWidget extends StatelessWidget {
  final int characterId;

  const DetailsWidget(this.characterId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        final loading = state.loading;
        final character = state.characterDetails;
        final series = state.series;
        final error = state.error;
        if (loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (loading == false && character != null && series != null) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BuildCharacterImage(character.bigThumbnailUrl),
                    if (character.description.isNotEmpty) BuildDescription(character.description),
                    if (series.isNotEmpty) BuildSeries(series),
                  ],
                ),
              ),
            ),
          );
        }
        if (loading == false && error != null) {
          return ErrorPage(
            onRetry: () {
              context.read<DetailsBloc>().add(
                    DetailsEvent(characterId),
                  );
            },
            error: error.toString(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
