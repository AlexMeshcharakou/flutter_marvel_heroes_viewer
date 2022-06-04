import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel/data/models/local_models/local_character.dart';

abstract class LocalDataSource {
  Future<void> charactersToDB(LocalCharacter character);

  List<LocalCharacter> getCharactersFromDB();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> charactersToDB(LocalCharacter character) async {
    var box = Hive.box('characters');
    await box.add(character);
  }

  @override
  List<LocalCharacter> getCharactersFromDB() {
    var box = Hive.box('characters');
    List<dynamic> characters = box.values.toList();
    return characters.cast<LocalCharacter>();
  }
}
