import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final String comics;

  Character(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnail,
      required this.comics});

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
