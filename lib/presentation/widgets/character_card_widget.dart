import 'package:flutter/material.dart';

class CharacterCardWidget extends StatelessWidget {
  final dynamic _item;

  const CharacterCardWidget( this._item,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      elevation: 3,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: (_item.smallThumbnailUrl != null)
                ? Image.network(
                    _item.smallThumbnailUrl,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.broken_image);
                    },
                  )
                : Image.asset("assets/images/placeholder.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: SizedBox(
              width: 200,
              child: Text(
                _item.name,
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
