import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';
import 'package:path_provider/path_provider.dart';

import 'presentation/navigation/route_generator.dart';
import 'presentation/features/heroes/heroes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentDir =
  await getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentDir.path);
  Hive.registerAdapter<LocalCharacter>(LocalCharacterAdapter());
  Hive.registerAdapter<LocalThumbnail>(LocalThumbnailAdapter());
  await Hive.openBox('characters');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeroesPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
