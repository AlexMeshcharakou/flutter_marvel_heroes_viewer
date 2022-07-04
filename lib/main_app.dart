import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'presentation/features/heroes/heroes_page.dart';
import 'presentation/localization/locale_bloc.dart';
import 'presentation/localization/locale_state.dart';
import 'presentation/navigation/route_generator.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      create: (context) => LocaleBloc(const LocaleState(locale: Locale('en'))),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.red),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            home: const HeroesPage(),
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
