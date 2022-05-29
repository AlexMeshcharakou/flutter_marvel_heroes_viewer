import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_event.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';
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
                  fontSize: 24,
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
                    _buildImage(character.bigThumbnailUrl),
                    if (character.description.isNotEmpty) _buildDescription(character.description),
                    if (series.isNotEmpty) _buildSeries(series),
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
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildImage(String? url) {
  return SizedBox(
    width: 300,
    height: 230,
    child: Card(
      color: Colors.blue[50],
      elevation: 10,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: (url != null)
              ? Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (_, __, ___) {
                    return const Icon(Icons.broken_image);
                  },
                )
              : Image.asset("assets/images/placeholder.png"),
        ),
      ),
    ),
  );
}

Widget _buildDescription(String description) {
  return Column(
    children: [
      const Text(
        'DESCRIPTION',
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        width: 370,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            description,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ],
  );
}

Widget _buildSeries(series) {
  return Column(
    children: [
      const Text(
        'SERIES',
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: series?.length,
          itemBuilder: (BuildContext context, int index) {
            final item = series![index];
            return Column(
              children: [
                Expanded(
                  flex: 9,
                  child: SizedBox(
                    width: 130,
                    child: Card(
                      color: Colors.blue[50],
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: (item.thumbnailUrl != null)
                            ? FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder.png",
                                image: item.thumbnailUrl,
                                fit: BoxFit.fitWidth,
                                imageErrorBuilder: (_, __, ___) {
                                  return const Icon(Icons.broken_image);
                                },
                              )
                            : Image.asset("assets/images/placeholder.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Text(item.title),
                  width: 115,
                  height: 50,
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
