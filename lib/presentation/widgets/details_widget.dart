import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';
import 'package:marvel/presentation/features/details/bloc/details_bloc.dart';
import 'package:marvel/presentation/features/details/bloc/details_state.dart';

class DetailsWidget extends StatelessWidget {
  final int characterId;

  const DetailsWidget(this.characterId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        final loading = state.loading;
        final character = state.character;
        final allSeries = state.allSeries;
        final error = state.error;
        if (loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (loading == false && character != null && allSeries != null) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildImage(character.thumbnail),
                  if (character.description.isNotEmpty) _buildDescription(character.description),
                  if (allSeries.isNotEmpty) _buildSeries(allSeries),
                ],
              ),
            ),
          );
        }
        if (loading == false && error != null) {
          return const Center(
            child: Text('ERROR'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildImage(Thumbnail thumbnail) {
  return SizedBox(
    width: 300,
    height: 230,
    child: Card(
      color: Colors.blue[50],
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(_createThumbnailUrl(thumbnail), fit: BoxFit.fitWidth),
            ),
          ),
        ],
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

Widget _buildSeries(allSeries) {
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
          itemCount: allSeries?.length,
          itemBuilder: (BuildContext context, int index) {
            final item = allSeries![index];
            return Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Card(
                    color: Colors.blue[50],
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: (item != null)
                          ? Image.network(_createThumbnailUrlSeries(item), fit: BoxFit.fitWidth)
                          : Image.asset("assets/images/placeholder.png"),
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

String _createThumbnailUrlSeries(Series item) {
  return item.thumbnail.path + '/portrait_medium.' + item.thumbnail.extension;
}

String _createThumbnailUrl(Thumbnail thumbnail) {
  return thumbnail.path + '/landscape_xlarge.' + thumbnail.extension;
}
