import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/marvel_bloc.dart';
import 'package:marvel/bloc/marvel_event.dart';
import 'package:marvel/bloc/marvel_state.dart';
import 'package:marvel/services/app_routes.dart';

class ListCharacters extends StatelessWidget {
  const ListCharacters({Key? key}) : super(key: key);


  String _createThumbnailUrl(item) {
    if (item != null) {
      return item.thumbnail.path +
          '/landscape_medium.' +
          item.thumbnail.extension;
    }
    return ''; // what better to return?
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
        if (state is CharactersLoadedState) {
          return ListView.builder(
            itemCount: state.loadedCharacters.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.loadedCharacters[index];
              return SizedBox(
                height: 100,
                child: GestureDetector(
                  onTap: () {
                MarvelBloc marvelBloc = context.read<MarvelBloc>();
                marvelBloc.add(DetailsLoadEvent(item.id));
                Navigator.pushNamed(context, AppRoutes.detailPage);
                print(item.id);
                },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    elevation: 5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                            child: Image.network(
                              _createThumbnailUrl(item),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                         Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              item.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state is MarvellErrorState) {
          return const Center(
            child: Text('ERROR'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
