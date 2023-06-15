import 'package:count_of_monet/model/helper/SettingsHelper.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/provider/ProfileProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSelect extends StatelessWidget {
  const ThemeSelect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    SettingsHelper settingsHelper = SettingsHelper(context: context);
    return Selector<PreferenceProvider, ThemeMode>(
        selector: (context, provider) => provider.themeMode,
        builder: (context, themeMode, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.themeSelect,
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'Light mode',
                    ),
                    Switch(
                      value: themeMode == ThemeMode.light ? false : true,
                      onChanged: (value) {
                        late ThemeMode themeMode;
                        if (value) {
                          themeMode = ThemeMode.dark;
                        } else {
                          themeMode = ThemeMode.light;
                        }
                        settingsHelper.updateTheme(
                          theme: themeMode,
                          settingId: preferenceProvider.preference.themeModeId,
                        );
                      },
                      activeTrackColor: Color(0xFFffd100),
                      activeColor: Color(0xFFffd100),
                    ),
                    Icon(
                      Icons.dark_mode,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'Dark mode',
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
