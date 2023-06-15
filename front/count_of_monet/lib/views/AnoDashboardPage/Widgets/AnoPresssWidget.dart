import 'package:count_of_monet/Widgets/MyLoadingWidget.dart';
import 'package:count_of_monet/model/core/RssFeed.dart';
import 'package:count_of_monet/model/helper/FluxRssHelper.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/dashboardPage/Widgets/PressWidget.dart';
import 'package:flutter/material.dart';

class AnoPresssWidget extends StatelessWidget {
  const AnoPresssWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return FutureBuilder<List<RssFeed>>(
      future: FluxRssHelper().getFluxRss(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MyLoadingWidget(height: 150, width: 150);
        }
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              alignment: Alignment.center,
              child: Text(
                lang.press,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: snapshot.data!
                      .map((e) => PressWidget(rssFeed: e))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
