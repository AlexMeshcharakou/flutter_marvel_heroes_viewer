import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionWidget extends StatelessWidget {
  final String _description;

  const DescriptionWidget(this._description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.description,
          style: const TextStyle(fontSize: 20),
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
