import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: (snapshot.data as List<dynamic>)
                  .map(
                    (character) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: ListTile(
                        isThreeLine: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0.5, vertical: 0),
                        title: Image.network(
                          character.thumbnail['path'].toString() +
                              '/landscape_medium.'+
                              character.thumbnail['extension'].toString(),
                          width: 150,
                          height: 90,
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          width: 250,
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                character.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(character.id.toString())
                            ],
                          ),
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
}
