import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel/model/character.dart';

const _uri =
    'https://gateway.marvel.com:443/v1/public/characters?modifiedSince=2016-03-05T13%3A17%3A50-0500&limit=100&ts=2&apikey=c1bba7288e4f2f4f744591622a48412b&hash=bab03858fdeab2fe461725bad8d65904';

class NetworkService {
  Future<List<Character>?> get() async {
    final response = await http.get(
      Uri.parse(_uri),
    );
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
