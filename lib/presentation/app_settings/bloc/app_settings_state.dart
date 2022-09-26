import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppSettingsState extends Equatable {
  final Locale locale;
  final ThemeData themeData;

  const AppSettingsState({required this.themeData, required this.locale});

  AppSettingsState copyWith({Locale? locale, ThemeData? themeData}) =>
      AppSettingsState(locale: locale ?? this.locale, themeData: themeData ?? this.themeData);

  @override
  List<Object?> get props => [locale, themeData];
}
