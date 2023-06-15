import 'package:count_of_monet/model/core/RssFeed.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PressWidget extends StatelessWidget {
  const PressWidget({Key? key, required this.rssFeed}) : super(key: key);

  final RssFeed rssFeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: Colors.grey.shade500,
      ),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            print(rssFeed.link);
            launchUrl(
              Uri.parse(rssFeed.link),
              mode: LaunchMode.externalApplication,
            );
          },
          child: Text(
            rssFeed.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ]),
    );
  }
}
