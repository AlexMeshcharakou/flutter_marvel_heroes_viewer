import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/features/heroes/widgets/list_characters.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/service_locator.dart';

class HeroesPage extends StatefulWidget {
  final Function changeToDarkTheme;
  final Function changeToLightTheme;
  final Function changeToRussian;
  final Function changeToEnglish;

  const HeroesPage(
      {Key? key,
      required this.changeToDarkTheme,
      required this.changeToLightTheme,
      required this.changeToRussian,
      required this.changeToEnglish})
      : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  bool themeIsSwitched = false;
  bool languageIsSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.marvel,
          style: const TextStyle(fontSize: 34),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.settings),
              );
            },
          )
        ],
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 64,
                child: buildDrawerHeader(context),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.sunny),
                      const SizedBox(width: 4),
                      buildThemesSwitch(),
                      const Icon(Icons.mode_night_outlined),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      buildText('En'),
                      buildLanguagesSwitch(),
                      buildText('Ru'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
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

  DrawerHeader buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Text(
        AppLocalizations.of(context)!.settings,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Switch buildLanguagesSwitch() {
    return Switch(
      value: languageIsSwitched,
      onChanged: (value) {
        setState(
          () {
            languageIsSwitched = value;
            if (languageIsSwitched) {
              widget.changeToRussian();
            } else {
              widget.changeToEnglish();
            }
          },
        );
      },
      activeColor: Colors.red,
    );
  }

  Switch buildThemesSwitch() {
    return Switch(
      value: themeIsSwitched,
      onChanged: (value) {
        setState(
          () {
            themeIsSwitched = value;
            if (themeIsSwitched) {
              widget.changeToDarkTheme();
            } else {
              widget.changeToLightTheme();
            }
          },
        );
      },
      activeColor: Colors.red,
    );
  }

  Text buildText(String language) => Text(language, style: const TextStyle(fontSize: 20));
}
