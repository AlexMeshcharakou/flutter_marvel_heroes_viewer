import 'package:flutter/material.dart';
import 'package:marvel/data/model/character.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/screens/details_page.dart';
import 'package:marvel/presentation/screens/heroes_page.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.heroesPage:
        return MaterialPageRoute(
          builder: (context) => HeroesPage(),
        );
      case AppRoutes.detailPage:
        final args = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
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
