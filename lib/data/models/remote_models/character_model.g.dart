// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseModel _$ApiResponseModelFromJson(Map<String, dynamic> json) =>
    ApiResponseModel(
      data: ApiResponseDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiResponseModelToJson(ApiResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ApiResponseDataModel _$ApiResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    ApiResponseDataModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiResponseDataModelToJson(
        ApiResponseDataModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      title: json['title'] as String?,
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail:
          ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

ThumbnailModel _$ThumbnailModelFromJson(Map<String, dynamic> json) =>
    ThumbnailModel(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$ThumbnailModelToJson(ThumbnailModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
