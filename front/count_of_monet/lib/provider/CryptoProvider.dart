import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:flutter/cupertino.dart';

class CryptoProvider extends ChangeNotifier {
  Crypto? _crypto;

  List<Crypto> _listCrypto = [];

  List<Crypto> _listCryptoAno = [];

  String _searchField = "";

  String _filter = "";

  Crypto? get crypto => _crypto;
  set crypto(Crypto? crypto) {
    _crypto = crypto;
    notifyListeners();
  }

  set setCrypto(Crypto? crypto) {
    _crypto = crypto;
  }

  List<Crypto> get listCrypto => _listCrypto;
  set listCrypto(List<Crypto> listCrypto) {
    _listCrypto = listCrypto;
    notifyListeners();
  }

  set setListCrypto(List<Crypto> listCrypto) {
    _listCrypto = listCrypto;
  }

  List<Crypto> get listCryptoAno => _listCryptoAno;
  set listCryptoAno(List<Crypto> value) {
    _listCryptoAno = value;
    notifyListeners();
  }

  set setListCryptoAno(List<Crypto> value) {
    _listCryptoAno = value;
  }

  String get searchField => _searchField;
  set searchField(String searchField) {
    _searchField = searchField;
    notifyListeners();
  }

  set setSearchField(String searchField) {
    _searchField = searchField;
  }

  String get filter => _filter;
  set filter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  set setFilter(String filter) {
    _filter = filter;
  }
}
