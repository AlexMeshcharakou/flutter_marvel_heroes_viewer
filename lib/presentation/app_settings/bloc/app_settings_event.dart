import 'package:equatable/equatable.dart';

abstract class AppSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangedToEnglishEvent extends AppSettingsEvent {}

class ChangedToRussianEvent extends AppSettingsEvent {}

class ChangedToDarkTheme extends AppSettingsEvent {}

class ChangedToLightTheme extends AppSettingsEvent {}
