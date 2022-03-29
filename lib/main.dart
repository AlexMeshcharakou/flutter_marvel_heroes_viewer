import 'package:flutter/material.dart';
import 'package:marvel/services/navigator_app.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigatorApp(),
    ),
  );
}
