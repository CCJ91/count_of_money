import 'package:count_of_monet/views/dashboardPage/Widgets/CryptosWidget.dart';
import 'package:count_of_monet/views/dashboardPage/Widgets/PresssWidget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: CryptosWidget(),
          ),
          Container(
            height: 400,
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: PresssWidget(),
          ),
        ],
      ),
    );
  }
}
