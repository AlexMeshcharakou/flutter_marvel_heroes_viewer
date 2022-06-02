import 'package:hive/hive.dart';

part 'local_character.g.dart';

@HiveType(typeId: 0)
class LocalCharacter {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final LocalThumbnail thumbnail;

  LocalCharacter(this.id, this.name, this.title, this.description, this.thumbnail);
}

@HiveType(typeId: 1)
class LocalThumbnail {
  @HiveField(0)
  final String path;
  @HiveField(1)
  final String extension;

  LocalThumbnail(this.path, this.extension);
}
