import 'package:count_of_monet/model/helper/AuthHelper.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/ProfileProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationForm extends StatelessWidget {
  const InformationForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userInformationKey = GlobalKey<FormState>();
    AuthHelper authHelper = AuthHelper();
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    TextEditingController textEditingControllerEmail =
        TextEditingController(text: authenticationProvider.userEmail);
    TextEditingController textEditingControllerName =
        TextEditingController(text: authenticationProvider.userFullName);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: userInformationKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Informations',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 250,
              child: Selector<AuthenticationProvider, String>(
                selector: (context, provider) => provider.userFullName,
                builder: (context, userFullName, child) {
                  return TextFormField(
                    controller: textEditingControllerName,
                    //initialValue: userFullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return lang.enterYourName;
                      }
                      profileProvider.tempName = value;
                      // authenticationProvider.userFullName = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              child: Selector<AuthenticationProvider, String>(
                selector: (context, provider) => provider.userEmail,
                builder: (context, userEmail, child) {
                  return TextFormField(
                    controller: textEditingControllerEmail,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return lang.emailInvalid;
                      }
                      profileProvider.tempEmail = value;
                      // authenticationProvider.userEmail = value;
                      return null;
                    },
                    //initialValue: userEmail,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    if (userInformationKey.currentState!.validate()) {
                      if (await authHelper.updateAccount(
                        email: profileProvider.tempEmail,
                        username: profileProvider.tempName,
                        token: authenticationProvider.token,
                      )) {
                        authenticationProvider.userEmail =
                            profileProvider.tempEmail;
                        authenticationProvider.userFullName =
                            profileProvider.tempName;
                      } else {
                        textEditingControllerName.text =
                            authenticationProvider.userFullName;
                        textEditingControllerEmail.text =
                            authenticationProvider.userEmail;
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF87f587),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      lang.save,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
