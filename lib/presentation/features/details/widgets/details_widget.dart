import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
import 'package:marvel/presentation/features/details/widgets/description_widget.dart';
import 'package:marvel/presentation/features/details/widgets/series_widget.dart';
import 'package:marvel/presentation/widgets/character_image_widget.dart';
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
                AppLocalizations.of(context)!.name + character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
                    CharacterImageWidget(character.bigThumbnailUrl),
                    if (character.description.isNotEmpty) DescriptionWidget(character.description),
                    if (series.isNotEmpty) SeriesWidget(series),
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
                    ReadyForDetailsEvent(characterId),
                  );
            },
            error: error,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
