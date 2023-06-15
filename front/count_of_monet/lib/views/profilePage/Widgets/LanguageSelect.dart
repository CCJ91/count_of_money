import 'package:count_of_monet/model/core/LanguageItem.dart';
import 'package:count_of_monet/model/helper/SettingsHelper.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/provider/ProfileProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = [
      LanguageItem('fr', 'assets/images/franceIcon.png'),
      LanguageItem('en', 'assets/images/englandIcon.png'),
    ];
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    SettingsHelper settingsHelper = SettingsHelper(context: context);
    return Selector<PreferenceProvider, String?>(
        selector: (context, provider) =>
            provider.preference.prefSelectedLanguageCode,
        builder: (context, selectedLanguage, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.selectLanguage,
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: (DropdownButton<String>(
                      value: selectedLanguage,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) async {
                        if (value == null) return;
                        //profileProvider.selectedLanguage = languages
                        //    .firstWhere((element) => element.key == value);
                        if (await settingsHelper.updateLanguage(
                            lang: value,
                            settingId:
                                preferenceProvider.preference.languageCodeId)) {
                          preferenceProvider.updateLanguage(value);
                        }
                      },
                      items: languages
                          .map(
                            (LanguageItem item) => DropdownMenuItem<String>(
                              value: item.key,
                              child: Image.asset(item.value!),
                            ),
                          )
                          .toList())),
                ),
              ],
            ),
          );
        });
  }
}
