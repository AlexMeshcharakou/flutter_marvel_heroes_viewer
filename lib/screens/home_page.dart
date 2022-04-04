import 'package:flutter/material.dart';
import 'package:marvel/model/character.dart';
import 'package:marvel/services/app_routes.dart';

import 'package:marvel/services/network_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Marvel',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder(
        future: NetworkService().get(),
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
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListView(
              children: (snapshot.data as List<dynamic>)
                  .where((character) =>
                      character.thumbnail['path'] !=
                      'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available')
                  .where((character) => character.description.isNotEmpty)
                  .map(
                    (character) => Container(
                      height: 102,
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.blue[50],
                          child: MyListTile(context, character),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  ListTile MyListTile(BuildContext context, character) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.secondPage,
          arguments: Character(
              id: character.id,
              name: character.name,
              description: character.description,
              thumbnail: character.thumbnail),
        );
      },
      isThreeLine: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      title: Image.network(
        character.thumbnail['path'].toString() +
            '/landscape_small.' +
            character.thumbnail['extension'].toString(),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        width: 270,
        height: 80,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                width: 250,
                height: 27,
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ),
            Text(
              character.id.toString(),
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
