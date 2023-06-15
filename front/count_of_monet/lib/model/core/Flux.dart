class Flux {
  String fluxId;

  String link;

  String siteName;

  bool display;

  Flux({
    required this.fluxId,
    required this.link,
    required this.siteName,
    required this.display,
  });

  factory Flux.fromJson(Map<String, dynamic> json) {
    return Flux(
      fluxId: json["id"].toString(),
      link: json["lien"].toString(),
      siteName: json["site"].toString(),
      display: json["display"],
    );
  }
}
