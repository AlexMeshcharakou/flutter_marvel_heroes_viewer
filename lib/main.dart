import 'package:flutter/material.dart';

import 'presentation/navigation/route_generator.dart';
import 'presentation/screens/heroes_page.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeroesPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
