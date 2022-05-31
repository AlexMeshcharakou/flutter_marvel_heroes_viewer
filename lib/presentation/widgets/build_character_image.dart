import 'package:flutter/material.dart';

class BuildCharacterImage extends StatelessWidget {
  final String? _url;

  const BuildCharacterImage(this._url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 230,
      child: Card(
        color: Colors.blue[50],
        elevation: 10,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: (_url != null)
                ? Image.network(
                    _url!,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.broken_image);
                    },
                  )
                : Image.asset("assets/images/placeholder.png"),
          ),
        ),
      ),
    );
  }
}