class MiniCrypto {
  String name;

  String symbol;

  String id;

  bool isFav;

  MiniCrypto({
    required this.name,
    required this.symbol,
    required this.id,
    required this.isFav,
  });

  factory MiniCrypto.fromJson(Map<String, dynamic> json) {
    return MiniCrypto(
      name: json["crypto_name"],
      symbol: json["symbole"],
      id: json["crypto_id"],
      isFav: json["favori"],
    );
  }

  @override
  String toString() {
    return "$name, $symbol, $id, $isFav";
  }
}

// List<MiniCrypto> listCryptoname = [
//   MiniCrypto(isFav: false, name: "Bitcoin", symbol: "btc", id: "bitcoin"),
//   MiniCrypto(isFav: false, name: "Ethereum", symbol: "eth", id: "ethereum"),
//   MiniCrypto(isFav: false, name: "Tether", symbol: "usdt", id: "tether"),
//   MiniCrypto(isFav: false, name: "BNB", symbol: "bnb", id: "binancecoin"),
//   MiniCrypto(isFav: false, name: "USD Coin", symbol: "usdc", id: "usd-coin"),
//   MiniCrypto(
//       isFav: false, name: "Binance USD", symbol: "busb", id: "binance-usd"),
//   MiniCrypto(isFav: false, name: "XRP", symbol: "xrp", id: "ripple"),
//   MiniCrypto(isFav: false, name: "Dogecoin", symbol: "doge", id: "dogecoin"),
//   MiniCrypto(isFav: false, name: "Cardano", symbol: "ada", id: "cardano"),
//   MiniCrypto(
//       isFav: false, name: "Polygon", symbol: "matic", id: "matic-network"),
//   MiniCrypto(isFav: false, name: "Polkadot", symbol: "dot", id: "polkadot"),
//   MiniCrypto(isFav: false, name: "Litecoin", symbol: "ltc", id: "litecoin"),
//   MiniCrypto(isFav: false, name: "Dai", symbol: "dai", id: "dai"),
//   MiniCrypto(isFav: false, name: "Shiba Inu", symbol: "shib", id: "shiba-inu"),
//   MiniCrypto(isFav: false, name: "Solana", symbol: "sol", id: "solana"),
//   MiniCrypto(isFav: false, name: "TRON", symbol: "trx", id: "tron"),
//   MiniCrypto(isFav: false, name: "Uniswap", symbol: "uni", id: "uniswap"),
//   MiniCrypto(
//       isFav: false, name: "Avalanche", symbol: "avax", id: "avalanche-2"),
//   MiniCrypto(isFav: false, name: "Chainlink", symbol: "link", id: "chainlink"),
//   MiniCrypto(
//       isFav: false,
//       name: "Wrapped Bitcoin",
//       symbol: "wbtc",
//       id: "wrapped-bitcoin"),
//   MiniCrypto(isFav: false, name: "Cosmos", symbol: "atom", id: "cosmos"),
//   MiniCrypto(
//       isFav: false,
//       name: "Ethereum Classic",
//       symbol: "etc",
//       id: "ethereum-classic"),
//   MiniCrypto(isFav: false, name: "Monero", symbol: "xmr", id: "monero"),
//   MiniCrypto(
//       isFav: false, name: "Toncoin", symbol: "ton", id: "the-open-network"),
//   MiniCrypto(isFav: false, name: "Stellar", symbol: "xlm", id: "stellar"),
//   MiniCrypto(
//       isFav: false, name: "Bitcoin Cash", symbol: "bch", id: "bitcoin-cash"),
//   MiniCrypto(
//       isFav: false, name: "Cronos", symbol: "cro", id: "crypto-com-chain"),
//   MiniCrypto(isFav: false, name: "Algorand", symbol: "algo", id: "algorand"),
//   MiniCrypto(isFav: false, name: "Filecoin", symbol: "fil", id: "filecoin"),
// ];
