import 'package:flutter/material.dart';

class BuildDescription extends StatelessWidget {
  final String _description;

  const BuildDescription(this._description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'DESCRIPTION',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          width: 370,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              _description,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
