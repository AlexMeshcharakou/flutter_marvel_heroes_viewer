import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(const MainApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LocalCharacter>(LocalCharacterAdapter());
  await Hive.openBox('characters');
}
