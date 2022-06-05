import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';

abstract class LocalDataSource {
  Future<void> save(LocalCharacter character);

  List<LocalCharacter> getAll();

  Future<void> deleteAll();
}

class HiveDataSource implements LocalDataSource {
  @override
  Future<void> save(LocalCharacter character) async {
    var box = Hive.box('characters');
    await box.add(character);
  }

  @override
  List<LocalCharacter> getAll() {
    var box = Hive.box('characters');
    List<dynamic> characters = box.values.toList();
    return characters.cast<LocalCharacter>();
  }

  @override
  Future<void> deleteAll() async {
    var box = Hive.box('characters');
    await box.clear();
  }
}
