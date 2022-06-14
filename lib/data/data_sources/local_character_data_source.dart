import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';

abstract class LocalCharacterDataSource {
  void save(LocalCharacter character);

  List<LocalCharacter> getAll();

  void deleteAll();
}

class HiveDataSource implements LocalCharacterDataSource {
  @override
  void save(LocalCharacter character)  {
    var box = Hive.box('characters');
    box.add(character);
  }

  @override
  List<LocalCharacter> getAll() {
    var box = Hive.box('characters');
    List<dynamic> characters = box.values.toList();
    return characters.cast<LocalCharacter>();
  }

  @override
  void deleteAll()  {
    var box = Hive.box('characters');
    box.clear();
  }
}
