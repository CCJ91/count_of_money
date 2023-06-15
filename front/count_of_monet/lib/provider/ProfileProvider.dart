import 'package:count_of_monet/model/core/LanguageItem.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String userOldPassword = '';
  String userNewPassword = '';
  String userConfirmPassword = '';

  String tempName = "";
  String tempEmail = "";

  String _message = "";

  LanguageItem? _selectedLanguage;
  bool _selectedTheme = false;

  LanguageItem? get selectedLanguage => _selectedLanguage;
  set selectedLanguage(LanguageItem? selectedLanguage) {
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }

  bool get selectedTheme => _selectedTheme;
  set selectedTheme(bool selectectedTheme) {
    _selectedTheme = selectectedTheme;
    print(selectectedTheme);
    notifyListeners();
  }

  String get message => _message;
  set message(String value) {
    _message = value;
    notifyListeners();
  }
}
