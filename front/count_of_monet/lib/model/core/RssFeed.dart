import 'package:count_of_monet/utils/StringWithoutUnicode.dart';

class RssFeed {
  String title;
  String description;
  String link;

  RssFeed({
    required this.title,
    required this.description,
    required this.link,
  });

  factory RssFeed.fromJson(Map<String, dynamic> json) {
    return RssFeed(
      title: json["title"].toString().noUnicode(),
      description: json["description"].toString().noUnicode(),
      link: json["link"].toString().noUnicode(),
    );
  }

  factory RssFeed.empty() {
    return RssFeed(
      title: "",
      description: "",
      link: "",
    );
  }

  @override
  String toString() {
    return "RssFeed : $title, $link, $description";
  }
}
