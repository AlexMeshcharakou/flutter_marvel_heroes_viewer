import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/services/network_service.dart';
import 'package:marvel/widgets/list_characters.dart';

class HeroesPage extends StatelessWidget {
  const HeroesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Marvel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: NetworkService().getCharacters(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return ListCharacters(characters: snapshot.data as List<Character>);
        },
      ),
    );
  }
}
