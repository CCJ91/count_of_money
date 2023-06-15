import 'package:count_of_monet/model/core/Preference.dart';
import 'package:count_of_monet/model/service/SettingsService.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsHelper {
  SettingsHelper({
    required this.context,
  }) {
    authentication =
        Provider.of<AuthenticationProvider>(context, listen: false);
    preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
  }
  late AuthenticationProvider authentication;
  late PreferenceProvider preferenceProvider;
  BuildContext context;
  SettingsService settingsService = SettingsService();

  Future<void> getSettingsAnonyme() async {
    await Future.delayed(Duration(seconds: 1));
    Preference preference = await settingsService.getSettingsAnonyme();
    preferenceProvider.updateLanguage(preference.prefSelectedLanguageCode);
    preferenceProvider.updateThemeMode(
        preference.themeMode ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> updateTheme({
    required ThemeMode theme,
    required int settingId,
  }) async {
    if (await settingsService.updateTheme(
      settingId: settingId,
      theme: theme == ThemeMode.light ? 'light' : 'dark',
      token: authentication.token,
    )) {
      print("update theme");
      preferenceProvider.updateThemeMode(theme);
    }
  }

  Future<bool> updateLanguage({
    required String lang,
    required int settingId,
  }) async {
    print(settingId);
    return settingsService.updateLanguage(
        settingId: settingId, lang: lang, token: authentication.token);
  }
}
