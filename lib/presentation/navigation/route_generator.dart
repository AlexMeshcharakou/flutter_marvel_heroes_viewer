import 'package:flutter/material.dart';
import 'package:marvel/presentation/features/details/details_page.dart';
import 'package:marvel/presentation/features/search/search_page.dart';
import 'package:marvel/presentation/navigation/app_routes.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.detailPage:
        final characterId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            characterId: characterId,
          ),
        );
      case AppRoutes.searchPage:
        return MaterialPageRoute(
          builder: (context) => const SearchPage(),
        );
    }
    return null;
  }
}
