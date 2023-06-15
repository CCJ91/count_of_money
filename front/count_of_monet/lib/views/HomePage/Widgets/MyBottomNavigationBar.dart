import 'package:count_of_monet/provider/CryptoProvider.dart';
import 'package:count_of_monet/provider/NavigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late NavigationProvider navigationProvider;
  late CryptoProvider cryptoProvider;

  @override
  void initState() {
    navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NavigationProvider, int>(
      selector: (context, provider) => provider.index,
      builder: (context, index, child) {
        return BottomNavigationBar(
          onTap: (value) {
            cryptoProvider.setCrypto = null;
            navigationProvider.index = value;
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          backgroundColor: Color(0xfffca311),
          selectedItemColor: Color(0xff800f2f),
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              label: lang.home,
              icon: Container(
                alignment: Alignment.center,
                height: 40,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: index == 0 ? 40 : 35,
                    child: Image.asset("assets/images/Paint.png")),
              ),
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: index == 1 ? 40 : 35,
                  child: Image.asset("assets/images/Crypto.png")),
              label: "Crypto",
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: index == 2 ? 40 : 35,
                  child: Image.asset("assets/images/Press.png")),
              label: lang.press,
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: index == 3 ? 40 : 35,
                  child: Image.asset("assets/images/Profile.png")),
              label: lang.profile,
            ),
          ],
        );
      },
    );
  }
}
