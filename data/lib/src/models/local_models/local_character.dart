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
  final String? smallThumbnailUrl;
  @HiveField(5)
  final String? bigThumbnailUrl;

  LocalCharacter(
      {this.smallThumbnailUrl,
      this.bigThumbnailUrl,
      required this.id,
      required this.name,
      this.title,
      required this.description});

  @override
  String toString() {
    return 'LocalCharacter{id: $id, name: $name, title: $title, description: $description, smallThumbnailUrl: $smallThumbnailUrl, bigThumbnailUrl: $bigThumbnailUrl}';
  }
}
