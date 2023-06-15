import 'package:count_of_monet/model/core/Crypto.dart';
import 'package:count_of_monet/model/helper/CryptoHelper.dart';
import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/provider/NavigationProvider.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/views/CryptoPage/CryptoPage.dart';
import 'package:count_of_monet/views/DashboardPage/Widgets/PresssWidget.dart';
import 'package:count_of_monet/views/DetailCryptoPage/DetailCryptoPage.dart';
import 'package:count_of_monet/views/HomePage/Widgets/MyAppBar.dart';
import 'package:count_of_monet/views/HomePage/Widgets/MyBottomNavigationBar.dart';
import 'package:count_of_monet/views/dashboardPage/DashboardPage.dart';
import 'package:count_of_monet/views/profilePage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    CryptoHelper cryptoHelper = CryptoHelper(context: context);
    cryptoHelper.getAllCrypto();
    print("getAllCrypto");
    return Scaffold(
      appBar: MyAppBar(),
      body: Selector2<NavigationProvider, CryptoProvider, Tuple2<int, Crypto?>>(
        selector: (context, provider1, provider2) =>
            Tuple2(provider1.index, provider2.crypto),
        builder: (context, tuple2, child) {
          if (tuple2.item2 != null) {
            return DetailCryptoPage(
              crypto: tuple2.item2!,
            );
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: preferenceProvider.themeMode == ThemeMode.light
                ? Colors.grey.shade100
                : Colors.grey.shade700,
            child: <Widget>[
              DashboardPage(),
              CryptoPage(),
              PresssWidget(),
              ProfilePage()
            ][tuple2.item1],
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
