import 'package:count_of_monet/model/helper/CryptoHelper.dart';
import 'package:count_of_monet/model/helper/SettingsHelper.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/views/AnoDashboardPage/AnoDashboardPage.dart';
import 'package:count_of_monet/views/HomeAnoPage/Widgets/MyAnoAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAnoPage extends StatelessWidget {
  const HomeAnoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    CryptoHelper cryptoHelper = CryptoHelper(context: context);
    SettingsHelper settingsHelper = SettingsHelper(context: context);
    cryptoHelper.getAllCryptoAno();
    settingsHelper.getSettingsAnonyme();
    return Scaffold(
      appBar: MyAnoAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: preferenceProvider.themeMode == ThemeMode.light
            ? Colors.grey.shade100
            : Colors.grey.shade600,
        child: AnoDashboardPage(),
      ),
    );
  }
}
