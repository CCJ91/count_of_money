import 'dart:io';

import 'package:count_of_monet/model/core/Preference.dart';
import 'package:count_of_monet/utils/database/PreferenceDatabase.dart';
import 'package:flutter/material.dart';

class PreferenceProvider extends ChangeNotifier {
  final PreferenceDatabase _preferenceDatabase = PreferenceDatabase();

  ThemeMode _themeMode = ThemeMode.system;

  late Preference preference;

  late Locale _locale;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  void loadPreference() async {
    preference = _preferenceDatabase.getPreference() ??
        Preference(
          themeMode: true,
          prefSelectedLanguageCode: Platform.localeName.substring(0, 2),
          themeModeId: 0,
          languageCodeId: 0,
        );
    _themeMode = preference.themeMode ? ThemeMode.light : ThemeMode.dark;
    _locale = getLocale();
  }

  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();

    preference.themeMode = (newThemeMode == ThemeMode.light);

    _preferenceDatabase.setPreference(preference: preference);
  }

  Locale getLocale() {
    String languagePhone = Platform.localeName.substring(0, 2);
    String languageCode = preference.prefSelectedLanguageCode;
    if (languageCode.isEmpty) languageCode = languagePhone;
    return Locale(languageCode, '');
  }

  Future<String> getLanguageCode() async {
    String languagePhone = Platform.localeName.substring(0, 2);
    String languageCode = preference.prefSelectedLanguageCode;
    if (languageCode.isEmpty) languageCode = languagePhone;
    return languageCode;
  }

  void updateLanguage(String? selectedLanguageCode) async {
    if (selectedLanguageCode == null) return;
    _locale = Locale.fromSubtags(languageCode: selectedLanguageCode);
    notifyListeners();
    // settingsHelper.updateLanguage(
    //   lang: selectedLanguageCode,
    //   settingId: 3,
    // );
    preference.prefSelectedLanguageCode = selectedLanguageCode;
    _preferenceDatabase.setPreference(preference: preference);
  }

  bool _isVisible = false;

  String _message = "";

  String name = "";

  String email = "";

  String password = "";

  String password2 = "";

  bool get isVisible => _isVisible;
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  String get message => _message;
  set message(String value) {
    _message = value;
    notifyListeners();
  }

  set setMessage(String value) {
    _message = value;
  }
}
