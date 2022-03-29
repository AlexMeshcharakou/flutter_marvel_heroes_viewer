import 'package:flutter/material.dart';

import 'package:marvel/services/network_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  FutureBuilder(
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
            return  ListView(
              children: (snapshot.data as List<dynamic>)
                  .map(
                    (photo) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 3, vertical: 2),
                  title: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 270,
                      height: 110,
                      child: Center(
                        child: Text(
                          photo.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
