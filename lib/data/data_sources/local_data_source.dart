import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';

abstract class LocalDataSource {
  void save(List<LocalCharacter> characters);

  List<LocalCharacter> getAll();
}

class HiveDataSource implements LocalDataSource {
  @override
  void save(List<LocalCharacter> characters) {
    var box = Hive.box('characters');
    box.clear();
    box.addAll(characters);
  }

  @override
  List<LocalCharacter> getAll() {
    var box = Hive.box('characters');
    List<dynamic> characters = box.values.toList();
    return characters.cast<LocalCharacter>();
  }
}
