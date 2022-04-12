import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/widgets/details_widget.dart';

import '../model/series.dart';
import '../services/network_service.dart';

class DetailsPage extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;

  const DetailsPage({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: FutureBuilder(
        future: NetworkService().getAllSeries(
          id.toString(),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return DetailsWidget(
            character: Character(
                id: id,
                name: name,
                description: description,
                thumbnail: thumbnail),
            allSeries: snapshot.data as List<Series>,
          );
        },
      ),
    );
  }
}
