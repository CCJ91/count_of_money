import 'dart:convert';

import 'package:count_of_monet/model/core/Preference.dart';
import 'package:count_of_monet/model/core/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class AuthApi {
  String baseUrl = dotenv.env['API_URL']!;

  Future<bool> signup({
    required String email,
    required String name,
    required String password,
  }) async {
    Uri uri = Uri.parse("$baseUrl/user/register");
    http.Response response;
    print("$baseUrl/user/register");
    try {
      response = await http.post(
        uri,
        body: jsonEncode(
          {
            "username": name,
            "email": email,
            "password": password,
            "oauth": "rien",
            "profil": "user",
          },
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
    if (response.statusCode == 200) {
      return true;
    }
    print(response.statusCode);
    print(response.body);
    return false;
  }

  Future<Tuple3<User, Preference, int>> login({
    required String email,
    required String password,
  }) async {
    Uri uri = Uri.parse("$baseUrl/user/login");
    http.Response response;
    print("$baseUrl/user/login");
    try {
      response = await http.post(
        uri,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
    } catch (e) {
      print(e);
      return Tuple3(User.empty(), Preference.empty(), 404);
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String token;
      User user;
      Preference preference;
      try {
        List iterable = json['body'].toList();
        token = iterable[0]['token'] ?? "";
        user = User.fromJson(iterable[1]);

        List list = iterable[2];
        preference = Preference.empty();
        for (Map<String, dynamic> map in list) {
          if (map["setting_name"] == "language") {
            preference.prefSelectedLanguageCode = map['status'];
            preference.languageCodeId = map['id'];
          } else if ((map['setting_name'] == "mode")) {
            preference.themeMode = map['status'].toString() == "light";
            preference.themeModeId = map['id'];
          }
        }
        user.token = token;
      } catch (e) {
        print(e);
        return Tuple3(User.empty(), Preference.empty(), 500);
      }
      return Tuple3(user, preference, 200);
    }

    return Tuple3(User.empty(), Preference.empty(), 500);
  }

  Future<bool> updateAccount({
    required String email,
    required String name,
    required String token,
  }) async {
    Uri uri = Uri.parse("$baseUrl/user");
    http.Response response;
    print("$baseUrl/user");
    print({
      "username": name,
      "email": email,
    });
    try {
      response = await http.put(
        uri,
        headers: {
          "x-access-tokens": token,
        },
        body: jsonEncode(
          {
            "username": name,
            "email": email,
          },
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["status"].toString() == "200";
    }

    return false;
  }

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    Uri uri = Uri.parse("$baseUrl/user/password");
    http.Response response;
    print("$baseUrl/user/password");
    try {
      response = await http.put(
        uri,
        headers: {
          "x-access-tokens": token,
        },
        body: jsonEncode(
          {
            "old_password": oldPassword,
            "new_password": newPassword,
          },
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["status"].toString() == "200";
    }

    return false;
  }
}
