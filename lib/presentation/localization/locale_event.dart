import 'package:equatable/equatable.dart';

abstract class LocaleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangedToEnglishEvent extends LocaleEvent {}

class ChangedToRussianEvent extends LocaleEvent {}
