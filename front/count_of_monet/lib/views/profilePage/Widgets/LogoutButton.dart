import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return ElevatedButton(
        onPressed: () {
          authenticationProvider.token = "";
        },
        child: Text(lang.logout));
  }
}
