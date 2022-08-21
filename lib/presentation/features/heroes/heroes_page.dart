import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/widgets/language_picker.dart';
import 'package:marvel/presentation/widgets/list_characters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/service_locator.dart';
import 'package:domain/domain_module.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({Key? key}) : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.marvel,
          style: const TextStyle(
            fontSize: 30,
          ),
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
        create: (context) => HeroesBloc(context: context, getCharactersUseCase: getIt.get<GetCharactersUseCase>())
          ..add(ReadyForDataEvent()),
        child: const ListCharacters(),
      ),
    );
  }
}
