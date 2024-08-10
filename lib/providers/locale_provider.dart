import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('en', '');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['en', 'es'].contains(locale.languageCode)) {
      throw Exception('Unsupported locale');
    }
    _locale = locale;
    notifyListeners();
  }
}
