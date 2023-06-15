import 'package:hive_flutter/hive_flutter.dart';

part 'Crypto.g.dart';

@HiveType(typeId: 1)
class Crypto {
  @HiveField(0)
  String cryptoId; //["id"] "bitcoin"
  @HiveField(1)
  String symbol; //["symbol"] "btc"
  @HiveField(2)
  String name; //["name"] "Bitcoin"
  @HiveField(3)
  String linkImage; //["image"]["large"]
  @HiveField(4)
  String genesisDate; //["genesis_date"]
  @HiveField(5)
  String twitterName; //["twitter_screen_name"] "bitcoin"
  @HiveField(6)
  String facebookName; //["facebook_username"] "bitcoins"
  @HiveField(7)
  String redditLink; //["subreddit_url"] "https://www.reddit.com/r/Bitcoin"
  @HiveField(8)
  double
      currentPrice; //["market_data"]["current_price"] ["usd"]/["eur"] 16505.31/15904.17
  @HiveField(9)
  double ath; //["market_data"]["ath"] ["usd"]/["eur"] 69045/59717
  @HiveField(10)
  double
      athChangePer; //["market_data"]["ath_change_percentage"] ["usd"]/["eur"] -76.07205/-73.3559
  @HiveField(11)
  int markerCap; //["market_data"]["market_cap"] ["usd"]/["eur"] 317663915173/306180999968
  @HiveField(12)
  int volume; //["market_data"]["total_volume"] ["usd"]/["eur"] 25954292449/25009011163
  @HiveField(13)
  double high24; //["market_data"]["high_24"] ["usd"]/["eur"] 16541.11/15953.29
  @HiveField(14)
  double low24; //["market_data"]["low_24"] ["usd"]/["eur"] 16065.43/15446.35
  @HiveField(15)
  double priceChange24h; //["market_data"]["price_change_24h"] 1.77395
  @HiveField(16)
  bool isFav;

  Crypto({
    required this.cryptoId,
    required this.symbol,
    required this.name,
    required this.linkImage,
    required this.genesisDate,
    required this.twitterName,
    required this.facebookName,
    required this.redditLink,
    required this.currentPrice,
    required this.ath,
    required this.athChangePer,
    required this.markerCap,
    required this.volume,
    required this.high24,
    required this.low24,
    required this.priceChange24h,
    required this.isFav,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      cryptoId: json["id"].toString(),
      symbol: json["symbol"].toString(),
      name: json["name"].toString(),
      linkImage: json["image"]["large"].toString(),
      genesisDate: json["genesis_date"].toString(),
      twitterName: json["twitter_screen_name"].toString(),
      facebookName: json["facebook_username"].toString(),
      redditLink: json["subreddit_url"].toString(),
      currentPrice:
          double.parse(json["market_data"]["current_price"]["usd"].toString()),
      ath: double.parse(json["market_data"]["ath"]["usd"].toString()),
      athChangePer: double.parse(
          json["market_data"]["ath_change_percentage"]["usd"].toString()),
      markerCap: int.parse(json["market_data"]["market_cap"]["usd"].toString()),
      volume: int.parse(json["market_data"]["total_volume"]["usd"].toString()),
      high24: double.parse(json["market_data"]["high_24h"]["usd"].toString()),
      low24: double.parse(json["market_data"]["low_24h"]["usd"].toString()),
      priceChange24h: double.parse(
          json["market_data"]["price_change_percentage_24h"].toString()),
      isFav: false,
    );
  }

  factory Crypto.empty() {
    return Crypto(
      cryptoId: "",
      symbol: "",
      name: "",
      linkImage: "",
      genesisDate: "",
      twitterName: "",
      facebookName: "",
      redditLink: "",
      currentPrice: 0,
      ath: 0,
      athChangePer: 0,
      markerCap: 0,
      volume: 0,
      high24: 0,
      low24: 0,
      priceChange24h: 0,
      isFav: false,
    );
  }

  @override
  String toString() {
    return "$cryptoId$symbol,$name,$linkImage,$genesisDate,$twitterName,$facebookName,$redditLink,$currentPrice,$ath,$athChangePer,$markerCap,$volume,$high24,$low24,$priceChange24h,$isFav";
  }
}
