import 'package:count_of_monet/views/AnoDashboardPage/Widgets/AnoCryptosWidget.dart';
import 'package:count_of_monet/views/AnoDashboardPage/Widgets/AnoPresssWidget.dart';
import 'package:count_of_monet/views/AnoDashboardPage/Widgets/HeroWidget.dart';
import 'package:flutter/material.dart';

class AnoDashboardPage extends StatelessWidget {
  const AnoDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: HeroWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: AnoCryptosWidget(),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: AnoPresssWidget(),
          ),
        ],
      ),
    );
  }
}
