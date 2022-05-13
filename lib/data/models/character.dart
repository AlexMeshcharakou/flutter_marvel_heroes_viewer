import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class ApiResponseModel {
  final ApiResponseDataModel data;

  ApiResponseModel({
    required this.data,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => _$ApiResponseModelFromJson(json);
}

@JsonSerializable()
class ApiResponseDataModel {
  final List<CharacterModel> results;

  ApiResponseDataModel({
    required this.results,
  });

  factory ApiResponseDataModel.fromJson(Map<String, dynamic> json) => _$ApiResponseDataModelFromJson(json);
}

@JsonSerializable()
class CharacterModel {
  final int id;
  final String name;
  final String? title;
  final String description;
  final ThumbnailModel thumbnail;

  CharacterModel({
    this.title,
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

@JsonSerializable()
class ThumbnailModel {
  final String path;
  final String extension;

  ThumbnailModel({
    required this.path,
    required this.extension,
  });

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) => _$ThumbnailModelFromJson(json);
}
