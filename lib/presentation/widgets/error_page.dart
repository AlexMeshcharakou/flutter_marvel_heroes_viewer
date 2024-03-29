import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorPage extends StatelessWidget {
  final Function onRetry;
  final Exception? error;

  const ErrorPage({Key? key, required this.onRetry, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = 'Error';
    if (error is DataRetrievingException) {
      message = AppLocalizations.of(context)!.somethingWentWrong;
    } else if (error is NoInternetException) {
      message = AppLocalizations.of(context)!.pleaseCheckInternetConnection;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.tryAgain,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.refresh_rounded, size: 24.0),
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
