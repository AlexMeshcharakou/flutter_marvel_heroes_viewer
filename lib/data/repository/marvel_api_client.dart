import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:marvel/data/models/character.dart';
import 'package:marvel/data/models/series.dart';

class MarvelApiClient {
  final String publicKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  Dio dio = Dio();

  Future<List<Character>> getCharacters() async {
    final response =
        await dio.get('https://gateway.marvel.com:443/v1/public/characters?limit=20&ts=2&apikey=$publicKey&hash=$hash');
    if (response.statusCode != 200) {
      return Future.error("network error");
    }
    final Map<String, dynamic> apiResponse = response.data;
    final apiResponseData = ApiResponse.fromJson(apiResponse);
    final result = apiResponseData.data.results;
    List<Character> characters = result
        .map(
          (item) => Character(id: item.id, name: item.name, description: item.description, thumbnail: item.thumbnail),
        )
        .toList();
    return characters;
  }

  Future<Character> getCharacter(int characterId) async {
    final response = await dio
        .get('https://gateway.marvel.com:443/v1/public/characters/$characterId?ts=2&apikey=$publicKey&hash=$hash');
    if (response.statusCode != 200) {
      return Future.error("network error");
    }
    final Map<String, dynamic> apiResponse = response.data;
    final apiResponseData = ApiResponse.fromJson(apiResponse);
    final result = apiResponseData.data.results;
    Character character = result
        .map(
          (item) => Character(id: item.id, name: item.name, description: item.description, thumbnail: item.thumbnail),
        )
        .single;
    return character;
  }

  Future<List<Series>> getSeries(int characterId) async {
    final response = await dio.get(
        'https://gateway.marvel.com:443/v1/public/characters/$characterId/series?ts=2&apikey=$publicKey&hash=$hash');
    if (response.statusCode != 200) {
      return Future.error(e);
    }
    final Map<String, dynamic> seriesResponse = response.data;
    final seriesResponseData = SeriesResponse.fromJson(seriesResponse);
    final data = seriesResponseData.data;
    List<Series>? allSeries = data.results
        .map(
          (item) => Series(title: item.title, description: item.description, thumbnail: item.thumbnail),
        )
        .toList();
    return allSeries;
  }
}
