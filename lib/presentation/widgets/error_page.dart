import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Function onRetry;

  const ErrorPage({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "NO CONNECTION",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Please check internet connection and ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "try again",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.refresh_rounded,
                  size: 24.0,
                ),
              ],
            ),
            onPressed: () {
              onRetry();
            },
          ),
        ],
      ),
    );
  }
}
