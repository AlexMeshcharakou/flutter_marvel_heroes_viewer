import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/heroes_bloc.dart';
import 'package:marvel/bloc/heroes_state.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';

class ListCharacters extends StatelessWidget {
  const ListCharacters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroesBloc, HeroesState>(
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.loading == false && state.characters != null) {
          return ListView.builder(
            itemCount: state.characters?.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.characters![index];
              return SizedBox(
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.detailPage,
                        arguments: Character(
                            id: item.id, name: item.name, description: item.description, thumbnail: item.thumbnail));
                  },
                  child: _buildCharacterCard(item),
                ),
              );
            },
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

  Widget _buildCharacterCard(Character item) {
    return Card(
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
              child: (item.thumbnail != null)
                  ? Image.network(_createThumbnailUrl(item.thumbnail), fit: BoxFit.fitWidth)
                  : Image.asset("assets/images/placeholder.png"),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                item.name,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _createThumbnailUrl(Thumbnail thumbnail) {
  return thumbnail.path + '/landscape_medium.' + thumbnail.extension;
}
