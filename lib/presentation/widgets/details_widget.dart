import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_bloc.dart';
import 'package:marvel/bloc/details_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';

class DetailsWidget extends StatelessWidget {
  final String description;
  final Thumbnail thumbnail;

  const DetailsWidget({Key? key, required this.description, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        final allSeries = state.allSeries;
        final loading = state.loading;
        final error = state.error;
        if (loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (loading == false && allSeries != null) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildImage(),
                if (description.isNotEmpty) const Text('DESCRIPTION', style: TextStyle(fontSize: 20)),
                _buildDescription(),
                if (allSeries.isNotEmpty) const Text('SERIES', style: TextStyle(fontSize: 20)),
                _buildSeries(allSeries),
              ],
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

  SizedBox _buildSeries(allSeries) {
    return SizedBox(
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
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: (item != null)
                      ? Image.network(_createThumbnailUrlSeries(item), fit: BoxFit.fitWidth)
                      : Image.asset("assets/images/placeholder.png"),
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
    );
  }

  Widget _buildDescription() {
    return SizedBox(
      width: 370,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            description,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
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
                child: (thumbnail != null)
                    ? Image.network(_createThumbnailUrl(thumbnail), fit: BoxFit.fitWidth)
                    : Image.asset("assets/images/placeholder.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _createThumbnailUrlSeries(Series item) {
    return item.thumbnail.path + '/portrait_medium.' + item.thumbnail.extension;
  }

  String _createThumbnailUrl(Thumbnail thumbnail) {
    return thumbnail.path + '/landscape_xlarge.' + thumbnail.extension;
  }
}
