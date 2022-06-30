import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({required this.locale});

  LocaleState copyWith({locale}) => LocaleState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];
}
