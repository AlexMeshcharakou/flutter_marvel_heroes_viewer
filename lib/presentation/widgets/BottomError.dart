import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_bloc.dart';
import 'package:marvel/presentation/features/heroes/bloc/heroes_event.dart';

class BottomError extends StatelessWidget {
  const BottomError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Check internet connection and Tap',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
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
