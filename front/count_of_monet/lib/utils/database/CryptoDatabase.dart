import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CryptoDatabase {
  Box box = Hive.box<Crypto>("CryptoBox");

  Crypto getCrypto({required String name}) {
    return box.get(name) ?? Crypto.empty();
  }

  void setCrypto({required Crypto crypto, required String name}) {
    box.put(name, crypto);
  }
}
