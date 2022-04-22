import 'package:json_annotation/json_annotation.dart';

part 'series.g.dart';

@JsonSerializable()
class SeriesResponse {
  final SeriesResponseData data;

  SeriesResponse({
    required this.data,
  });

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseFromJson(json);
}

@JsonSerializable()
class SeriesResponseData {
  final List<Series> results;

  SeriesResponseData({
    required this.results,
  });

  factory SeriesResponseData.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseDataFromJson(json);
}

@JsonSerializable()
class Series {
  final String title;
  final dynamic description;
  final ThumbnailSeries thumbnail;

  //
  Series({
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
}

@JsonSerializable()
class ThumbnailSeries {
  final String path;
  final String extension;

  ThumbnailSeries({
    required this.path,
    required this.extension,
  });

  factory ThumbnailSeries.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailSeriesFromJson(json);
}
