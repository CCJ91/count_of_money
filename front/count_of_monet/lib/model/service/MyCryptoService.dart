import 'dart:convert';

import 'package:count_of_monet/model/core/MiniCrypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyCryptoService {
  String baseUrl = dotenv.env['API_URL']!;

  Future<List<MiniCrypto>> getListMiniCrypto({required String token}) async {
    Uri uri = Uri.parse("$baseUrl/crypto/user");

    http.Response response;
    print("$baseUrl/crypto/user");
    print({"x-access-tokens": token});
    try {
      response = await http.get(uri, headers: {"x-access-tokens": token});
    } catch (e) {
      print(e);
      return [];
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json = jsonDecode(response.body);
        Iterable listJson = json['body'];
        List<MiniCrypto> list =
            listJson.map((e) => MiniCrypto.fromJson(e)).toList();
        return list;
      } catch (e) {
        print("catch fromJsonCrypto $e");
        return [];
      }
    }
    return [];
  }

  Future<bool> addToFav(
      {required String token, required String cryptoId}) async {
    Uri uri = Uri.parse("$baseUrl/crypto/user");

    http.Response response;
    print("$baseUrl/crypto/user");
    print({"x-access-tokens": token});
    print(cryptoId);
    try {
      response = await http.post(uri,
          headers: {
            "x-access-tokens": token,
          },
          body: jsonEncode({"crypto_id": cryptoId}));
    } catch (e) {
      print(e);
      return false;
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["message"] == "crypto favori save") {
      return true;
    }
    return false;
  }

  Future<bool> removeFromFav(
      {required String token, required String cryptoId}) async {
    Uri uri = Uri.parse("$baseUrl/crypto/user");

    http.Response response;
    print("$baseUrl/crypto/user");
    print({"x-access-tokens": token});
    try {
      response = await http.delete(uri,
          headers: {"x-access-tokens": token},
          body: jsonEncode({"crypto_id": cryptoId}));
    } catch (e) {
      print(e);
      return false;
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["message"] == "crypto favori delete") {
      return true;
    }
    return false;
  }

  Future<List<String>> getListCryptoAno() async {
    Uri uri = Uri.parse("$baseUrl/crypto/anonyme");

    http.Response response;
    print("$baseUrl/crypto/anonyme");
    try {
      response = await http.get(uri);
    } catch (e) {
      print(e);
      return [];
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json = jsonDecode(response.body);
        Iterable listJson = json['body'];
        List<String> list = listJson.map((e) => e.toString()).toList();
        return list;
      } catch (e) {
        print("catch fromJsonCrypto $e");
        return [];
      }
    }
    return [];
  }
}
