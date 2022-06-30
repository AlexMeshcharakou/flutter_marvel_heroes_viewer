import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/localization/locale_event.dart';
import 'package:marvel/presentation/localization/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(initialState) : super(initialState) {
    on<ChangedToEnglishEvent>(
      (event, emit) async {
        emit(
          state.copyWith(locale: const Locale('en')),
        );
      },
    );
    on<ChangedToRussianEvent>(
      (event, emit) async {
        emit(
          state.copyWith(locale: const Locale('ru')),
        );
      },
    );
  }
}
