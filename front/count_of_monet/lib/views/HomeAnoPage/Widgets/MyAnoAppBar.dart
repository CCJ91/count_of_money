import 'package:count_of_monet/provider/NavigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAnoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAnoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Count of ",
                  style: GoogleFonts.cinzel(
                    fontSize: 24,
                  ),
                ),
                TextSpan(
                  text: "Monet",
                  style: GoogleFonts.courgette(
                    color: Color(
                      0xffffd100,
                    ),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navigationProvider.index = 3;
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/Avatar.jpg"),
                ),
              ),
              width: 44,
              height: 44,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
