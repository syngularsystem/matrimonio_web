import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('it');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_locale') ?? 'it';
    _locale = Locale(saved);
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!['it', 'es', 'uk'].contains(newLocale.languageCode)) return;

    _locale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', newLocale.languageCode);

    notifyListeners();
  }
}
