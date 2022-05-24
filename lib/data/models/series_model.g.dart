// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponseModel _$SeriesResponseModelFromJson(Map<String, dynamic> json) =>
    SeriesResponseModel(
      data: SeriesResponseDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesResponseModelToJson(
        SeriesResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SeriesResponseDataModel _$SeriesResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    SeriesResponseDataModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesResponseDataModelToJson(
        SeriesResponseDataModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

SeriesModel _$SeriesModelFromJson(Map<String, dynamic> json) => SeriesModel(
      title: json['title'] as String,
      description: json['description'],
      thumbnail: ThumbnailSeriesModel.fromJson(
          json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesModelToJson(SeriesModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

ThumbnailSeriesModel _$ThumbnailSeriesModelFromJson(
        Map<String, dynamic> json) =>
    ThumbnailSeriesModel(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$ThumbnailSeriesModelToJson(
        ThumbnailSeriesModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
