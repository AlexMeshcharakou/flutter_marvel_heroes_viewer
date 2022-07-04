import 'package:flutter/material.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';
import 'package:marvel/presentation/features/details/details_page.dart';
import 'package:marvel/presentation/features/heroes/heroes_page.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.heroesPage:
        return MaterialPageRoute(
          builder: (context) => const HeroesPage(),
        );
      case AppRoutes.detailPage:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            characterId: args[0], name: args[1], url: args[2]
          ),
        );
    }
    return null;
  }
}
