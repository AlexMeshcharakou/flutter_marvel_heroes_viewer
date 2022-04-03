import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final Map<String, dynamic> thumbnail;

  const SecondPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.thumbnail,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 300,
              height: 500,
              child: Card(
                color: Colors.blue[50],
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            thumbnail['path'].toString() +
                                '/portrait_uncanny.' +
                                thumbnail['extension'].toString(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 255,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              description,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
