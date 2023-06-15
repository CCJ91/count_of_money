import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/model/core/MiniCrypto.dart';
import 'package:count_of_monet/model/service/CryptoService.dart';
import 'package:count_of_monet/model/service/MyCryptoService.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/utils/database/CryptoDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CryptoHelper {
  CryptoHelper({required this.context}) {
    cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);
    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
  }

  BuildContext context;

  late CryptoProvider cryptoProvider;
  late AuthenticationProvider authenticationProvider;

  CryptoService cryptoService = CryptoService();
  MyCryptoService myCryptoService = MyCryptoService();

  CryptoDatabase cryptoDatabase = CryptoDatabase();

  Future<void> getAllCrypto() async {
    cryptoProvider.setListCrypto = [];

    List<MiniCrypto> getListMiniCrypto = await myCryptoService
        .getListMiniCrypto(token: authenticationProvider.token);

    for (MiniCrypto miniCrypto in getListMiniCrypto) {
      Crypto crypto = await cryptoService.getCrypto(name: miniCrypto.id);

      if (crypto.cryptoId.isEmpty) {
        crypto = cryptoDatabase.getCrypto(name: miniCrypto.id);
      } else {
        cryptoDatabase.setCrypto(crypto: crypto, name: miniCrypto.id);
      }
      crypto.isFav = miniCrypto.isFav;

      cryptoProvider.listCrypto.add(crypto);
      cryptoProvider.listCrypto = cryptoProvider.listCrypto;

      await Future.delayed(Duration(milliseconds: 3000));
    }
  }

  Future<bool> addToFav({required String cryptoId}) async {
    return myCryptoService.addToFav(
        token: authenticationProvider.token, cryptoId: cryptoId);
  }

  Future<bool> removeFromFav({required String cryptoId}) async {
    return myCryptoService.removeFromFav(
        token: authenticationProvider.token, cryptoId: cryptoId);
  }

  Future<List<Tuple2<int, double>>> getMarketChart({required name}) async {
    return cryptoService.getMarketChart(name: name);
  }

  Future<void> getAllCryptoAno() async {
    cryptoProvider.setListCryptoAno = [];

    List<String> getListCryptoAno = await myCryptoService.getListCryptoAno();

    for (String value in getListCryptoAno) {
      Crypto crypto = await cryptoService.getCrypto(name: value);

      cryptoProvider.listCryptoAno.add(crypto);
      cryptoProvider.listCryptoAno = cryptoProvider.listCryptoAno;

      await Future.delayed(Duration(milliseconds: 1000));
    }
  }
}
