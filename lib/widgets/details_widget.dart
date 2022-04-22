import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/marvel_bloc.dart';
import 'package:marvel/bloc/marvel_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/data/model/series.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  String _createThumbnailUrl(Character character) {
    return character.thumbnail.path +
        '/landscape_xlarge.' +
        character.thumbnail.extension;
  }

  String _createThumbnailUrlSeries(Series item) {
    return item.thumbnail.path + '/portrait_medium.' + item.thumbnail.extension;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarvelBloc, MarvelState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DetailsLoadedState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  height: 395,
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
                            child: Image.network(''
                                // _createThumbnailUrl(character),
                                ),
                          ),
                        ),
                        const Expanded(
                          flex: 6,
                          child: SizedBox(
                            width: 280,
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  ' character.description',
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
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'SERIES',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.loadedAllSeries.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = state.loadedAllSeries[index];
                      print(item);
                      return Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                  _createThumbnailUrlSeries(item),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(
                            child: Text(item.title),
                            width: 120,
                            height: 50,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
