import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel/model/character.dart';
import 'package:marvel/model/series.dart';

class MarvelApiProvider {
  final String publicKey = 'c1bba7288e4f2f4f744591622a48412b';
  final String hash = 'bab03858fdeab2fe461725bad8d65904';

  Future<List<Character>> getCharacters() async {
    final response = await http.get(
      Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters?limit=20&ts=2&apikey=$publicKey&hash=$hash'),
    );
    if (response.statusCode != 200) {
      return Future.error(e);
    }
    final Map<String, dynamic> apiResponse = jsonDecode(response.body);
    final apiResponseData = ApiResponse.fromJson(apiResponse);
    final result = apiResponseData.data.results;
    List<Character> characters = result
        .map(
          (item) => Character(
              id: item.id,
              name: item.name,
              description: item.description,
              thumbnail: item.thumbnail),
        )
        .toList();
    return characters;
  }

  Future<List<Series>> getSeries(int characterId) async {
   print(characterId);
    final response = await http.get(
      Uri.parse(
          'https://gateway.marvel.com:443/v1/public/characters/$characterId/series?ts=2&apikey=$publicKey&hash=$hash'),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      return Future.error(e);
    }
    final Map<String, dynamic> seriesResponse = jsonDecode(response.body);
    final seriesResponseData = SeriesResponse.fromJson(seriesResponse);
    final data = seriesResponseData.data;
    List<Series>? allSeries = data.results
        .map(
          (item) => Series(
              title: item.title,
              description: item.description,
              thumbnail: item.thumbnail),
        )
        .toList();
    print(allSeries);
    return allSeries;
  }
}
