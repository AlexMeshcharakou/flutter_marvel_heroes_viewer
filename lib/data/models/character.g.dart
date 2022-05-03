// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      data: ApiResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) => <String, dynamic>{
      'data': instance.data,
    };

ApiResponseData _$ApiResponseDataFromJson(Map<String, dynamic> json) => ApiResponseData(
      results: (json['results'] as List<dynamic>).map((e) => Character.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$ApiResponseDataToJson(ApiResponseData instance) => <String, dynamic>{
      'results': instance.results,
    };

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      title: json['title'] as String?,
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail: Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
