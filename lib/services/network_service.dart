import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel/model/character.dart';

class NetworkService {
  Future<List<Character>?> get() async {
    final response = await http.get(Uri.parse(
        'https://gateway.marvel.com:443/v1/public/characters?limit=30&ts=2&apikey=c1bba7288e4f2f4f744591622a48412b&hash=bab03858fdeab2fe461725bad8d65904'));
    if (response.statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> responseMap = jsonDecode(response.body);
    final Map<String, dynamic> data = responseMap['data'];
    List<dynamic> body = data['results'];
    List<Character> characters = body
        .map(
          (item) => Character.fromJson(item),
        )
        .toList();
    return characters;
  }
}
