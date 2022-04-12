import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/services/app_routes.dart';

class ListCharacters extends StatelessWidget {
  final List<Character> characters;

  const ListCharacters({Key? key, required this.characters}) : super(key: key);

  String _createThumbnailUrl(item) {
    if (item != null) {
      return item.thumbnail.path +
          '/landscape_medium.' +
          item.thumbnail.extension;
    }
    return '';// what better to return?
  }

  @override
  Widget build(BuildContext context) {
    print(_createThumbnailUrl);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          final item = characters[index];
          return SizedBox(
            height: 100,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.detailPage,
                  arguments: Character(
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    thumbnail: item.thumbnail,
                  )),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
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
                          fit: BoxFit.fill,
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
      ),
    );
  }
}
