import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/app_settings/bloc/app_settings_event.dart';
import 'package:marvel/presentation/app_settings/theme_class.dart';

import 'presentation/app_settings/bloc/app_settings_bloc.dart';
import 'presentation/app_settings/bloc/app_settings_state.dart';
import 'presentation/features/heroes/heroes_page.dart';
import 'presentation/navigation/route_generator.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettingsBloc>(
      create: (context) =>
          AppSettingsBloc(AppSettingsState(locale: const Locale('en'), themeData: ThemeClass.lightTheme)),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            theme: state.themeData,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: HeroesPage(
              changeToDarkTheme: () {
                BlocProvider.of<AppSettingsBloc>(context).add(
                  ChangedToDarkTheme(),
                );
              },
              changeToLightTheme: () {
                BlocProvider.of<AppSettingsBloc>(context).add(
                  ChangedToLightTheme(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
