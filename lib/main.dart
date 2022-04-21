import 'package:flutter/material.dart';
import 'package:marvel/screens/heroes_page.dart';
import 'package:marvel/services/route_generator.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeroesPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
