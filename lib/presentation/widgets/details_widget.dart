import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/details_bloc.dart';
import 'package:marvel/bloc/details_page_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';

import 'my_image.dart';

class DetailsWidget extends StatelessWidget {
  final String description;
  final Thumbnail thumbnail;

  const DetailsWidget({Key? key, required this.description, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsPageState>(
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.loading == false && state.allSeries != null) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildImage(),
                _buildDescriptionTitle(),
                _buildDescription(),
                _buildSeriesTitle(state),
                _buildSeries(state),
              ],
            ),
          );
        }
        if (state.loading == false && state.error != null) {
          return const Center(
            child: Text('ERROR'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  SizedBox _buildSeries(DetailsPageState state) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.allSeries?.length,
        itemBuilder: (BuildContext context, int index) {
          final item = state.allSeries![index];
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MyImage(
                    _createThumbnailUrlSeries(item),
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
    );
  }

  Widget _buildSeriesTitle(DetailsPageState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: (state.allSeries != null) ? const Text('SERIES', style: TextStyle(fontSize: 20)) : const SizedBox.shrink(),
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

  Widget _buildDescriptionTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: (description.isNotEmpty)
          ? const Text('DESCRIPTION', style: TextStyle(fontSize: 20))
          : const SizedBox.shrink(),
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
                child: MyImage(
                  _createThumbnailUrl(thumbnail),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _createThumbnailUrl(Thumbnail thumbnail) {
    return thumbnail.path + '/landscape_xlarge.' + thumbnail.extension;
  }

  String _createThumbnailUrlSeries(Series item) {
    return item.thumbnail.path + '/portrait_medium.' + item.thumbnail.extension;
  }
}
