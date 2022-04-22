import 'package:flutter/material.dart';
import 'package:marvel/navigation/route_generator.dart';
import 'package:marvel/screens/heroes_page.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeroesPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
