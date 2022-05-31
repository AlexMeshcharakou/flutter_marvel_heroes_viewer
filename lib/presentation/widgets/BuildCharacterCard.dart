import 'package:flutter/material.dart';

class BuildCharacterCard extends StatelessWidget {
  final dynamic item;

  const BuildCharacterCard({Key? key, this.item}) : super(key: key);

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
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
              child: (item.smallThumbnailUrl != null)
                  ? Image.network(
                      item.smallThumbnailUrl,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.broken_image);
                      },
                    )
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
