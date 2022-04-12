// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) =>
    SeriesResponse(
      data: SeriesResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesResponseToJson(SeriesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SeriesResponseData _$SeriesResponseDataFromJson(Map<String, dynamic> json) =>
    SeriesResponseData(
      results: (json['results'] as List<dynamic>)
          .map((e) => Series.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesResponseDataToJson(SeriesResponseData instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      title: json['title'] as String,
      description: json['description'],
      thumbnail:
          ThumbnailSeries.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

ThumbnailSeries _$ThumbnailSeriesFromJson(Map<String, dynamic> json) =>
    ThumbnailSeries(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$ThumbnailSeriesToJson(ThumbnailSeries instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
