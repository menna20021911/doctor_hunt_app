import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void setLocale(Locale locale) {
    if (state.languageCode != locale.languageCode) {
      emit(locale);
    }
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      emit(const Locale('ar'));
    } else {
      emit(const Locale('en'));
    }
  }

  bool get isArabic => state.languageCode == 'ar';
}
