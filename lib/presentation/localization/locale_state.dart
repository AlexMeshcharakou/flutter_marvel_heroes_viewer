import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);
}

class SelectedLocale extends LocaleState {
  const SelectedLocale(Locale locale) : super(locale);

  @override
  List<Object?> get props => [locale];
}
