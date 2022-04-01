import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String description;
  final Map<String, dynamic> thumbnail;

  Character(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnail});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@JsonSerializable(createFactory: true)
class Thumbnail {
  final String path;
  final String extension;

  Thumbnail(this.path, this.extension);

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
}
