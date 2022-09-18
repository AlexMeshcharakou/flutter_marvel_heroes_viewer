import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/app_settings/bloc/app_settings_event.dart';
import 'package:marvel/presentation/app_settings/bloc/app_settings_state.dart';
import 'package:marvel/presentation/app_settings/theme_class.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc(initialState) : super(initialState) {
    on<ChangedToEnglishEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            locale: const Locale('en'),
          ),
        );
      },
    );
    on<ChangedToRussianEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            locale: const Locale('ru'),
          ),
        );
      },
    );
    on<ChangedToDarkTheme>(
      (event, emit) async {
        emit(
          state.copyWith(
            themeData: ThemeClass.darkTheme,
          ),
        );
      },
    );
    on<ChangedToLightTheme>(
      (event, emit) async {
        emit(
          state.copyWith(
            themeData: ThemeClass.lightTheme,
          ),
        );
      },
    );
  }
}
