import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/model/helper/CryptoHelper.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoWidget extends StatelessWidget {
  const CryptoWidget({Key? key, required this.crypto}) : super(key: key);

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    CryptoProvider cryptoProvider =
        Provider.of<CryptoProvider>(context, listen: false);
    CryptoHelper cryptoHelper = CryptoHelper(context: context);
    return GestureDetector(
      onTap: () => cryptoProvider.crypto = crypto,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: Row(
          children: [
            crypto.linkImage.isEmpty
                ? Container()
                : SizedBox(
                    height: 40,
                    child: Image.network(crypto.linkImage),
                  ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${crypto.name} ${crypto.symbol}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "${crypto.currentPrice}\$",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${crypto.priceChange24h.toStringAsFixed(2)}%",
                        style: TextStyle(
                          color: crypto.priceChange24h > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      Icon(
                        crypto.priceChange24h > 0
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: crypto.priceChange24h > 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                if (crypto.isFav) {
                  if (!await cryptoHelper.removeFromFav(
                      cryptoId: crypto.cryptoId)) {
                    return;
                  }
                } else {
                  if (!await cryptoHelper.addToFav(cryptoId: crypto.cryptoId)) {
                    return;
                  }
                }

                cryptoProvider.listCrypto
                    .firstWhere(
                        (element) => element.cryptoId == crypto.cryptoId)
                    .isFav = !crypto.isFav;
                cryptoProvider.listCrypto = cryptoProvider.listCrypto;
              },
              icon: Icon(
                crypto.isFav ? Icons.favorite : Icons.heart_broken,
                color: crypto.isFav ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
