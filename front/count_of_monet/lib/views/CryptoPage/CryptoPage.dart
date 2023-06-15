import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/CryptoPage/widget/CryptoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CryptoProvider cryptoProvider =
        Provider.of<CryptoProvider>(context, listen: false);
    cryptoProvider.setSearchField = "";
    cryptoProvider.setFilter = "";
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              "Cryptos",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                children: [
                  Text(lang.search),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        cryptoProvider.searchField = value;
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  Text(lang.filters),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Selector<CryptoProvider, String>(
                      selector: (context, provider) => provider.filter,
                      builder: (context, data, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    data == "AZ" ? Colors.blue.shade800 : null,
                              ),
                              onPressed: () {
                                if (cryptoProvider.filter == "AZ") {
                                  cryptoProvider.filter = "";
                                } else {
                                  cryptoProvider.filter = "AZ";
                                }
                              },
                              child: Text("A-Z"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    data == "ZA" ? Colors.blue.shade800 : null,
                              ),
                              onPressed: () {
                                if (cryptoProvider.filter == "ZA") {
                                  cryptoProvider.filter = "";
                                } else {
                                  cryptoProvider.filter = "ZA";
                                }
                              },
                              child: Text("Z-A"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: data == "HIGH"
                                    ? Colors.blue.shade800
                                    : null,
                              ),
                              onPressed: () {
                                if (cryptoProvider.filter == "HIGH") {
                                  cryptoProvider.filter = "";
                                } else {
                                  cryptoProvider.filter = "HIGH";
                                }
                              },
                              child: Icon(Icons.arrow_upward),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    data == "LOW" ? Colors.blue.shade800 : null,
                              ),
                              onPressed: () {
                                if (cryptoProvider.filter == "LOW") {
                                  cryptoProvider.filter = "";
                                } else {
                                  cryptoProvider.filter = "LOW";
                                }
                              },
                              child: Icon(Icons.arrow_downward),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    data == "FAV" ? Colors.blue.shade800 : null,
                              ),
                              onPressed: () {
                                if (cryptoProvider.filter == "FAV") {
                                  cryptoProvider.filter = "";
                                } else {
                                  cryptoProvider.filter = "FAV";
                                }
                              },
                              child: Text(lang.favorite),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Selector<CryptoProvider,
                          Tuple3<List<Crypto>, String, String>>(
                        selector: (context, provider) => Tuple3(
                            provider.listCrypto,
                            provider.searchField,
                            provider.filter),
                        shouldRebuild: (previous, next) => true,
                        builder: (context, data, child) {
                          List<Crypto> listCrypto = [];
                          switch (data.item3) {
                            case "AZ":
                              listCrypto = data.item1.toList();
                              listCrypto
                                  .sort((a, b) => a.name.compareTo(b.name));
                              break;
                            case "ZA":
                              listCrypto = data.item1.toList();
                              listCrypto
                                  .sort((a, b) => b.name.compareTo(a.name));
                              break;
                            case "HIGH":
                              listCrypto = data.item1.toList();
                              listCrypto.sort((a, b) =>
                                  b.priceChange24h.compareTo(a.priceChange24h));
                              break;
                            case "LOW":
                              listCrypto = data.item1.toList();
                              listCrypto.sort((a, b) =>
                                  a.priceChange24h.compareTo(b.priceChange24h));
                              break;
                            case "FAV":
                              listCrypto = data.item1
                                  .where((element) => element.isFav)
                                  .toList();
                              break;
                            default:
                              listCrypto = data.item1;
                          }
                          return Column(
                            children: listCrypto
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(data.item2.toLowerCase()))
                                .map(
                                  (crypto) => CryptoWidget(crypto: crypto),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
