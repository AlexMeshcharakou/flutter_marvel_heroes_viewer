import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final Map<String, dynamic> thumbnail;

  const ThirdPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.thumbnail,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(description);
  }
}
