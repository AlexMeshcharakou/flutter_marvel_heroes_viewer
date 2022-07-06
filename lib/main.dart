import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:marvel/main_app.dart';
import 'package:marvel/service_locator.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  setupGetIt();
  runApp(const MainApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LocalCharacter>(LocalCharacterAdapter());
  await Hive.openBox('characters');
}
