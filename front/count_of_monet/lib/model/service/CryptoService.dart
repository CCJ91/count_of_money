import 'dart:convert';

import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class CryptoService {
  String baseUrl = "https://api.coingecko.com/api/v3";

  Future<Crypto> getCrypto({required String name}) async {
    Uri uri = Uri.parse("$baseUrl/coins/$name");
    Crypto retCrypto = Crypto.empty();
    http.Response response;
    return Crypto.empty();
    print("$baseUrl/coins/$name");
    try {
      response = await http.get(uri);
    } catch (e) {
      print(e);
      return retCrypto;
    }
    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json = jsonDecode(response.body);
        retCrypto = Crypto.fromJson(json);
      } catch (e) {
        print("catch fromJsonCrypto $e");
        return retCrypto;
      }
      print("success:${retCrypto.name}");
    } else {
      print("fail:$name");
    }
    return retCrypto;
  }

  Future<List<Tuple2<int, double>>> getMarketChart(
      {required String name}) async {
    Uri uri = Uri.parse(
        "$baseUrl/coins/$name/market_chart?vs_currency=usd&days=7&interval=daily");
    List<Tuple2<int, double>> retList = [];
    http.Response response;
    print(
        "$baseUrl/coins/$name/market_chart?vs_currency=usd&days=7&interval=daily");
    try {
      response = await http.get(uri);
    } catch (e) {
      print(e);
      return retList;
    }
    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json = jsonDecode(response.body);
        Iterable list = json["prices"];
        retList = list.map((e) => Tuple2(e[0] as int, e[1] as double)).toList();
      } catch (e) {
        print("catch fromJsonCrypto $e");
        return retList;
      }
    }
    return retList;
  }
}
