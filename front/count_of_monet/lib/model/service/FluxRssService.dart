import 'dart:convert';

import 'package:count_of_monet/model/core/RssFeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class FluxRssService {
  Future<List<RssFeed>> getFluxRss({String? coinName}) async {
    late String url;
    if (coinName == null) {
      url = "https://coinjournal.net/fr/actualites/feed/";
    } else {
      url = "https://coinjournal.net/fr/actualites/tag/$coinName/feed/";
    }
    Uri uri = Uri.parse(url);
    print(url);
    Xml2Json xml2json = Xml2Json();
    http.Response response;
    try {
      response = await http.get(uri);
    } catch (e) {
      print(e);
      return [];
    }
    try {
      xml2json.parse(response.body);
    } catch (e) {
      return [];
    }

    xml2json.parse(response.body);

    String json = xml2json.toParker();

    Map<String, dynamic> jsonMap = jsonDecode(json);

    List list = jsonMap["rss"]["channel"]["item"];

    var listRssFeed = list.map((e) => RssFeed.fromJson(e)).toList();

    return listRssFeed;
  }
}
