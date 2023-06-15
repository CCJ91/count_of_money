import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/Avatar.jpg"),
              ),
            ),
            width: 100,
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Selector<AuthenticationProvider, String>(
                selector: (context, provider) => provider.userFullName,
                builder: (context, userFullName, child) {
                  return (RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: userFullName,
                        style: GoogleFonts.courgette(
                            fontSize: 24, color: Colors.black),
                      ),
                    ]),
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
