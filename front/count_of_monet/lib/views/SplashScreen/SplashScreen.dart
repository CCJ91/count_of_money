import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/views/HomeAnoPage/HomeAnoPage.dart';
import 'package:count_of_monet/views/HomePage/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AuthenticationProvider, String>(
      selector: (context, provider) => provider.token,
      builder: (context, data, child) {
        return data.isEmpty ? HomeAnoPage() : HomePage();
      },
    );
  }
}
