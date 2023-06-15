import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/dashboardPage/Widgets/CryptoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptosWidget extends StatelessWidget {
  const CryptosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          alignment: Alignment.center,
          child: Text(
            lang.favoritesCrypto,
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
            scrollDirection: Axis.horizontal,
            child: Selector<CryptoProvider, List<Crypto>>(
              selector: (context, provider) => provider.listCrypto,
              shouldRebuild: (previous, next) => true,
              builder: (context, data, child) {
                List<Crypto> listCrypto =
                    data.where((element) => element.isFav).toList();
                return data.isEmpty
                    ? Text(lang.noFavoriteCryptoMessage)
                    : Row(
                        children: listCrypto
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
