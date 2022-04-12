import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';

import '../model/series.dart';

class DetailsWidget extends StatelessWidget {
  final Character character;
  final List<Series> allSeries;

  const DetailsWidget({
    Key? key,
    required this.character,
    required this.allSeries,
  }) : super(key: key);

  String _createThumbnailUrl(character) {
    if (character != null) {
      return character.thumbnail.path +
          '/portrait_uncanny.' +
          character.thumbnail.extension;
    }
    return ''; // what better to return?
  }

  String _createThumbnailUrlSeries(item) {
    if (item != null) {
      return item.thumbnail.path +
          '/portrait_medium.' +
          item.thumbnail.extension;
    }
    return ''; // what better to return?
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 250,
            height: 395,
            child: Card(
              color: Colors.blue[50],
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(_createThumbnailUrl(character)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 255,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            character.description,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'SERIES',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allSeries.length,
            itemBuilder: (BuildContext context, int index) {
              final item = allSeries[index];
              return Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(_createThumbnailUrlSeries(item),
                          fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(
                    child: Text(item.title),
                    width: 110,
                    height: 30,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
