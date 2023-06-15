import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:flutter/material.dart';

class CryptoWidget extends StatelessWidget {
  const CryptoWidget({Key? key, required this.crypto}) : super(key: key);

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: Colors.grey.shade800,
      ),
      child: Column(
        children: [
          crypto.linkImage.isEmpty
              ? Container()
              : SizedBox(
                  height: 40,
                  child: Image.network(
                    crypto.linkImage,
                  ),
                ),
          Text(
            crypto.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, color: Color(0xffffd100)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${crypto.currentPrice}\$",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${crypto.priceChange24h.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: crypto.priceChange24h > 0 ? Colors.green : Colors.red,
                ),
              ),
              Icon(
                crypto.priceChange24h > 0
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: crypto.priceChange24h > 0 ? Colors.green : Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
