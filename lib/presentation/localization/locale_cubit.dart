import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/presentation/localization/locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(initialState) : super(initialState);

  void toRussian() => emit(const SelectedLocale(Locale('ru')));

  void toEnglish() => emit(const SelectedLocale(Locale('en')));

}