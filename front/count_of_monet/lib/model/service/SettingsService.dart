import 'package:count_of_monet/model/core/Preference.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsService {
  String baseUrl = dotenv.env['API_URL']!;

  Future<Preference> getSettingsAnonyme() async {
    Uri uri = Uri.parse("$baseUrl/setting/anonyme");
    http.Response response;
    print("$baseUrl/setting/anonyme");
    try {
      response = await http.get(
        uri,
      );
    } catch (e) {
      print(e);
      return Preference.empty();
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Preference preference = Preference.empty();
      List list = json['body'];
      for (Map<String, dynamic> map in list) {
        if (map["setting_name"] == "language") {
          preference.prefSelectedLanguageCode = map['status'];
          preference.languageCodeId = map['id'];
        } else if ((map['setting_name'] == "mode")) {
          preference.themeMode = map['status'].toString() == "light";
          preference.themeModeId = map['id'];
        }
      }
      return preference;
    }
    return Preference.empty();
  }

  Future<bool> updateTheme({
    required String theme,
    required String token,
    required int settingId,
  }) async {
    Uri uri = Uri.parse("$baseUrl/setting/user");
    http.Response response;
    print("$baseUrl/setting/user");
    try {
      response = await http.put(
        uri,
        headers: {"x-access-tokens": token},
        body: jsonEncode(
          {
            'setting_name': 'mode',
            'status': theme,
            'id': settingId,
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
      try {
        return json['status'].toString() == "200";
      } catch (e) {
        print(e);
        return false;
      }
    }

    return false;
  }

  Future<bool> updateLanguage({
    required String lang,
    required String token,
    required int settingId,
  }) async {
    Uri uri = Uri.parse("$baseUrl/setting/user");
    http.Response response;
    print("$baseUrl/setting/user");
    try {
      response = await http.put(
        uri,
        headers: {"x-access-tokens": token},
        body: jsonEncode(
          {
            'setting_name': 'language',
            'status': lang,
            'id': settingId,
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
