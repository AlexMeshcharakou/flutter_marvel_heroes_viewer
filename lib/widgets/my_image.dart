import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String? url;

  const MyImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return Image.network(url!, fit: BoxFit.fitWidth);
    }
    return const Text('Image unavailable');
  }
}
