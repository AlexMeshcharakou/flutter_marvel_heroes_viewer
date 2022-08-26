import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroesBottomError extends StatelessWidget {
  const HeroesBottomError({
    Key? key,
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
          context.read<HeroesBloc>().add(ScrolledToEndEvent());
        },
      ),
    );
  }
}
