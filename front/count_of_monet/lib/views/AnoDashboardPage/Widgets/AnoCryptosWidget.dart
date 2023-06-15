import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/views/dashboardPage/Widgets/CryptoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnoCryptosWidget extends StatelessWidget {
  const AnoCryptosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          alignment: Alignment.center,
          child: Text(
            "Cryptos",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Selector<CryptoProvider, List<Crypto>>(
              selector: (context, provider) => provider.listCryptoAno,
              shouldRebuild: (previous, next) => true,
              builder: (context, data, child) {
                return Row(
                  children: data
                      .map(
                        (crypto) => CryptoWidget(
                          crypto: crypto,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

// List<Crypto> listCrypto = [
//   Crypto.empty()
//     ..linkImage =
//         "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579"
//     ..name = "Bitcoin"
//     ..currentPrice = 16505.31
//     ..priceChange24h = 1.77395,
//   Crypto.empty()
//     ..linkImage =
//         "https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880"
//     ..name = "Ethereum"
//     ..currentPrice = 1212.48
//     ..priceChange24h = 3.36349,
//   Crypto.empty()
//     ..linkImage =
//         "https://assets.coingecko.com/coins/images/5/small/dogecoin.png?1547792256"
//     ..name = "Dogecoin"
//     ..currentPrice = 0.102485
//     ..priceChange24h = 7.63289,
// ];
