import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/presentation/features/search/bloc/search_bloc.dart';
import 'package:marvel/presentation/features/search/bloc/search_event.dart';

class SearchBottomError extends StatelessWidget {
  final String nameStartsWith;

  const SearchBottomError({
    Key? key,
    required this.nameStartsWith,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.checkInternetConnectionAndTap,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.refresh_rounded,
              size: 35.0,
            ),
          ],
        ),
        onPressed: () {
          context.read<SearchBloc>().add(ScrolledToEndSearchEvent(nameStartsWith: nameStartsWith));
        },
      ),
    );
  }
}
