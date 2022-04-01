import 'package:flutter/material.dart';
// import 'package:marvel/screens/second_page.dart';
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
      // case AppRoutes.secondPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const SecondPage(),
      //   );
    }
    return null;
  }
}
