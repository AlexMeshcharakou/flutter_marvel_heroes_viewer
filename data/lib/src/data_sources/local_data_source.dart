import 'package:hive/hive.dart';
import 'package:data/data_module.dart';

abstract class LocalDataSource {
  void save(List<LocalCharacter> characters);

  List<LocalCharacter> getAll();
}

class HiveDataSource implements LocalDataSource {
  final box = Hive.box('characters');

  @override
  void save(List<LocalCharacter> characters) {
    box.clear();
    box.addAll(characters);
  }

  @override
  List<LocalCharacter> getAll() {
    List<dynamic> characters = box.values.toList();
    return characters.cast<LocalCharacter>();
  }
}
