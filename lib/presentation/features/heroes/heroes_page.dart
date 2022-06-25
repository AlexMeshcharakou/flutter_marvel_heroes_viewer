import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/data/data_sources/local_character_data_source.dart';
import 'package:marvel/data/data_sources/remote_data_source.dart';
import 'package:marvel/data/repository/default_marvel_repository.dart';
import 'package:marvel/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:marvel/presentation/widgets/build_language_picker.dart';
import 'package:marvel/presentation/widgets/list_characters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({Key? key}) : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  final GetCharactersUseCase getAllCharactersUseCase = GetCharactersUseCase(
      marvelRepository: DefaultMarvelRepository(dioDataSource: DioDataSource(), hiveDataSource: HiveDataSource()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.marvel,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: const [
          BuildLanguagePicker(),
        ],
      ),
      body: BlocProvider<HeroesBloc>(
        create: (context) => HeroesBloc(getCharactersUseCase: getAllCharactersUseCase)..add(ReadyForDataEvent()),
        child: const ListCharacters(),
      ),
    );
  }
}
