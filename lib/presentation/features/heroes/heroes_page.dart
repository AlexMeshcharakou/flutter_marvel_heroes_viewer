import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/app_settings/widgets/language_picker.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/widgets/list_characters.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/service_locator.dart';

class HeroesPage extends StatefulWidget {
  final Function changeToDarkTheme;
  final Function changeToLightTheme;

  const HeroesPage({Key? key, required this.changeToDarkTheme, required this.changeToLightTheme}) : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(
                  () {
                    isSwitched = value;
                    if (isSwitched) {
                      widget.changeToDarkTheme();
                    } else {
                      widget.changeToLightTheme();
                    }
                  },
                );
              },
              activeColor: Colors.red,
            ),
            const Icon(Icons.mode_night_outlined)
          ],
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.marvel,
          style: const TextStyle(fontSize: 34),
        ),
        actions: const [
          LanguagePicker(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.searchPage);
        },
        child: const Icon(Icons.search),
      ),
      body: BlocProvider<HeroesBloc>(
        create: (context) =>
            HeroesBloc(getCharactersUseCase: getIt.get<GetCharactersUseCase>())..add(ReadyForDataEvent()),
        child: const ListCharacters(),
      ),
    );
  }
}
