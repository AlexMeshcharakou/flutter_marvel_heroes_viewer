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
        final characterId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            characterId: characterId,
          ),
        );
    }
    return null;
  }
}
