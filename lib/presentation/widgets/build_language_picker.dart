import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/localization/locale_cubit.dart';

class BuildLanguagePicker extends StatefulWidget {
  const BuildLanguagePicker({Key? key}) : super(key: key);

  @override
  State<BuildLanguagePicker> createState() => _BuildLanguagePickerState();
}

class _BuildLanguagePickerState extends State<BuildLanguagePicker> {
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
        dropdownColor: Colors.blue,
        onChanged: (String? newValue) {
          setState(
            () {
              dropdownValue = newValue!;
              if (dropdownValue == 'Ru') {
                BlocProvider.of<LocaleCubit>(context).toRussian();
              } else {
                BlocProvider.of<LocaleCubit>(context).toEnglish();
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
