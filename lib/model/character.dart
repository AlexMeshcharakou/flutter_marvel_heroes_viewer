import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class ApiResponse {
  final ApiResponseData data;

  ApiResponse({
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}

@JsonSerializable()
class ApiResponseData {
  final List<Character> results;

  ApiResponseData({
    required this.results,
  });

  factory ApiResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseDataFromJson(json);
}

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String? title;
  final String description;
  final Thumbnail thumbnail;

  Character({
    this.title,
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@JsonSerializable()
class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
}
