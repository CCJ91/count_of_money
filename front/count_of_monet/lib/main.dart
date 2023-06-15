import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/model/core/Preference.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/provider/NavigationProvider.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/provider/ProfileProvider.dart';
import 'package:count_of_monet/utils/languages/AppLocalizationsDelegate.dart';
import 'package:count_of_monet/utils/languages/LanguageEn.dart';
import 'package:count_of_monet/utils/languages/LanguageFr.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tuple/tuple.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load();

  Hive.registerAdapter<Preference>(PreferenceAdapter());
  Hive.registerAdapter<Crypto>(CryptoAdapter());

  await Hive.openBox<Preference>('PreferenceBox');
  await Hive.openBox<Crypto>('CryptoBox');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => CryptoProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: Builder(
        builder: (context) {
          PreferenceProvider preferenceProvider =
              Provider.of<PreferenceProvider>(context, listen: false);
          preferenceProvider.loadPreference();

          return Selector<PreferenceProvider, Tuple2<Locale, ThemeMode>>(
              selector: (context, provider) =>
                  Tuple2(provider.locale, provider.themeMode),
              builder: (context, data, child) {
                switch (data.item1.languageCode) {
                  case 'en':
                    language = LanguageEn();
                    break;
                  case 'fr':
                    language = LanguageFr();
                    break;
                  case 'es':
                    language = LanguageEn();
                    break;
                  default:
                    language = LanguageEn();
                    break;
                }

                return MaterialApp(
                  locale: preferenceProvider.locale,
                  localizationsDelegates: [
                    AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    Locale('fr', ''),
                    Locale('en', ''),
                    Locale('es', ''),
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    for (Locale supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                          locale?.languageCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  home: SplashScreen(),
                );
              });
        },
      ),
    );
  }
}
