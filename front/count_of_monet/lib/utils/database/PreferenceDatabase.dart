import 'package:count_of_monet/model/core/Preference.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PreferenceDatabase {
  Box box = Hive.box<Preference>("PreferenceBox");

  Preference? getPreference() {
    return box.get("pref");
  }

  void setPreference({required Preference preference}) {
    box.put("pref", preference);
  }

  /* Future<ThemeMode> getThemeMode() async {
    bool isLightTheme = (await getPreference()).themeMode;

    ThemeMode themeMode = isLightTheme ? ThemeMode.light : ThemeMode.dark;
    return themeMode;
  }

  void setThemeMode(ThemeMode theme) async {
    bool isLightTheme = (theme == ThemeMode.light);
    Preference preference = await getPreference();
    preference.themeMode = isLightTheme;
    await isar.writeTxn(() async {
      await isarCollection.put(preference);
    });
  }

  void setPrefSelectedLanguageCode(String? value) async {
    Preference preference = await getPreference();
    preference.prefSelectedLanguageCode = value ?? "";
    await isar.writeTxn(() async {
      await isarCollection.put(preference);
    });
  }

  Future<String> getPrefSelectedLanguageCode() async {
    Preference preference = await getPreference();
    return preference.prefSelectedLanguageCode;
  }

  void setPrefereNfcOrBl(bool value) async {
    Preference preference = await getPreference();
    preference.prefereNfcOrBl = value;
    await isar.writeTxn(() async {
      await isarCollection.put(preference);
    });
  }

  Future<bool> getPrefereNfcOrBl() async {
    Preference preference = await getPreference();
    return preference.prefereNfcOrBl;
  } */
}
