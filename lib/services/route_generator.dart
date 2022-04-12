import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/screens/details_page.dart';
import 'package:marvel/services/app_routes.dart';
import 'package:marvel/screens/heroes_page.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.heroesPage:
        return MaterialPageRoute(
          builder: (context) => const HeroesPage(),
        );
      case AppRoutes.detailPage:
        final args = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            id: args.id,
            name: args.name,
            thumbnail: args.thumbnail,
            description: args.description,
          ),
        );
    }
    return null;
  }
}
