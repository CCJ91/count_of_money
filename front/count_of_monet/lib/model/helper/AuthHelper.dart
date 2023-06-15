import 'package:count_of_monet/model/core/Preference.dart';
import 'package:count_of_monet/model/core/User.dart';
import 'package:count_of_monet/model/service/AuthApi.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class AuthHelper {
  AuthApi authApi = AuthApi();

  Future<bool> signup({
    required String email,
    required String name,
    required String password,
  }) async {
    return authApi.signup(email: email, name: name, password: password);
  }

  Future<int> login({
    required String email,
    required String password,
    required AuthenticationProvider authenticationProvider,
    required PreferenceProvider preferenceProvider,
  }) async {
    Tuple3<User, Preference, int> tuple3 =
        await authApi.login(email: email, password: password);

    if (tuple3.item3 == 404) {
      return 404;
    } else if ((tuple3.item1.token ?? "").isEmpty) {
      return 500;
    } else {
      authenticationProvider.token = tuple3.item1.token!;
      authenticationProvider.user = tuple3.item1;
      authenticationProvider.setUserEmail = tuple3.item1.email;
      authenticationProvider.setUserFullName = tuple3.item1.username;
      preferenceProvider.preference = tuple3.item2;
      preferenceProvider.updateLanguage(tuple3.item2.prefSelectedLanguageCode);
      preferenceProvider.updateThemeMode(
          tuple3.item2.themeMode ? ThemeMode.light : ThemeMode.dark);
      return 200;
    }
  }

  Future<bool> updateAccount({
    required String email,
    required String username,
    required String token,
  }) {
    return authApi.updateAccount(email: email, name: username, token: token);
  }

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) {
    return authApi.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      token: token,
    );
  }
}
