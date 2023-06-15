import 'package:count_of_monet/model/core/User.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider extends ChangeNotifier {
  String _token = "";

  User user = User.empty();

  String get token => _token;
  set token(String value) {
    _token = value;
    notifyListeners();
  }

  String _userFullName = '';
  String _userEmail = '';

  String get userFullName => _userFullName;
  set userFullName(String userFullName) {
    _userFullName = userFullName;
    notifyListeners();
  }

  set setUserFullName(String userFullName) {
    _userFullName = userFullName;
  }

  String get userEmail => _userEmail;
  set userEmail(String userEmail) {
    _userEmail = userEmail;
    notifyListeners();
  }

  set setUserEmail(String userEmail) {
    _userEmail = userEmail;
  }
}
