import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/localization/locale_bloc.dart';
import 'package:marvel/presentation/localization/locale_event.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  String dropdownValue = 'En';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        icon: const Icon(
          Icons.language,
          color: Colors.white,
          size: 18,
        ),
        value: dropdownValue,
        elevation: 24,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        dropdownColor: Colors.red,
        onChanged: (String? newValue) {
          setState(
            () {
              dropdownValue = newValue!;
              if (dropdownValue == 'Ru') {
                BlocProvider.of<LocaleBloc>(context).add(ChangedToRussianEvent());
              } else {
                BlocProvider.of<LocaleBloc>(context).add(ChangedToEnglishEvent());
              }
            },
          );
        },
        items: <String>['Ru', 'En'].map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}
