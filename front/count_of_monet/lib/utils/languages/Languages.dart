import 'package:count_of_monet/utils/languages/LanguageFr.dart';
import 'package:flutter/material.dart';

Languages? language;

Languages get lang {
  return language ?? LanguageFr();
}

abstract class Languages {
  String get selectLanguage;
  String get themeSelect;
  String get save;
  String get settings;
  String get changePassword;
  String get oldPassword;
  String get newPassword;
  String get confirmPassword;
  String get home;
  String get press;
  String get profile;
  String get enterYourName;
  String get emailInvalid;

  String get validationName;
  String get validationEmail;
  String get validationOldPassword;
  String get validationNewPassword;
  String get validationConfirmPassword;

  String get favoritesCrypto;
  String get noFavoriteCryptoMessage;
  String get favoritesPress;

  String get search;
  String get filters;
  String get favorite;

  String get currentPrice;
  String get genesisDate;
  String get ath;
  String get perSinceATH;
  String get last24Highest;
  String get last24Lowest;
  String get persince24h;
  String get volume;
  String get noDataRssFeed;

  //AnoPage
  String get login;
  String get logout;
  String get signup;
  String get email;
  String get yourEmail;
  String get username;
  String get yourUsername;
  String get password;
  String get yourPassword;
  String get verifyPassword;
  String get passwordDifferent;
  String get accountCreated;
  String get infoIncorrect;

  String get errorOccur;

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  //General
  String get loading; //Chargement
}
