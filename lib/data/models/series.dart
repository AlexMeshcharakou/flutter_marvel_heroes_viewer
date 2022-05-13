import 'package:json_annotation/json_annotation.dart';

part 'series.g.dart';

@JsonSerializable()
class SeriesResponseModel {
  final SeriesResponseDataModel data;

  SeriesResponseModel({
    required this.data,
  });

  factory SeriesResponseModel.fromJson(Map<String, dynamic> json) => _$SeriesResponseModelFromJson(json);
}

@JsonSerializable()
class SeriesResponseDataModel {
  final List<SeriesModel> results;

  SeriesResponseDataModel({
    required this.results,
  });

  factory SeriesResponseDataModel.fromJson(Map<String, dynamic> json) => _$SeriesResponseDataModelFromJson(json);
}

@JsonSerializable()
class SeriesModel {
  final String title;
  final dynamic description;
  final ThumbnailSeriesModel thumbnail;

  SeriesModel({
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) => _$SeriesModelFromJson(json);
}

@JsonSerializable()
class ThumbnailSeriesModel {
  final String path;
  final String extension;

  ThumbnailSeriesModel({
    required this.path,
    required this.extension,
  });

  factory ThumbnailSeriesModel.fromJson(Map<String, dynamic> json) => _$ThumbnailSeriesModelFromJson(json);
}
