import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/screens/second_page.dart';
import 'package:marvel/screens/third_page.dart';
import 'package:marvel/services/app_routes.dart';
import 'package:marvel/screens/home_page.dart';

class NavigatorApp extends StatelessWidget {
  const NavigatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case AppRoutes.secondPage:
        final args = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => SecondPage(
            id: args.id,
            name: args.name,
            description: args.description,
            thumbnail: args.thumbnail,
          ),
        );
      case AppRoutes.thirdPage:
        final args = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => ThirdPage(
            id: args.id,
            name: args.name,
            description: args.description,
            thumbnail: args.thumbnail,
          ),
        );
    }
    return null;
  }
}
