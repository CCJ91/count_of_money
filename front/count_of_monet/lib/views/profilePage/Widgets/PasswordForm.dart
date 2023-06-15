import 'package:count_of_monet/model/helper/AuthHelper.dart';
import 'package:count_of_monet/provider/AuthenticationProvider.dart';
import 'package:count_of_monet/provider/ProfileProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPasswordKey = GlobalKey<FormState>();

    AuthHelper authHelper = AuthHelper();

    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: userPasswordKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              lang.changePassword,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 250,
              child: Selector<ProfileProvider, String>(
                  selector: (context, provider) => provider.userOldPassword,
                  builder: (context, userOldPassword, child) {
                    return (TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        labelText: lang.oldPassword,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return lang.validationNewPassword;
                        }
                        profileProvider.userOldPassword = value;
                        return null;
                      },
                    ));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              child: Selector<ProfileProvider, String>(
                selector: (context, provider) => provider.userNewPassword,
                builder: (context, userNewPassword, child) {
                  return TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      labelText: lang.newPassword,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return lang.validationNewPassword;
                      }
                      profileProvider.userNewPassword = value;
                      return null;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250,
              child: Selector<ProfileProvider, String>(
                selector: (context, provider) => provider.userConfirmPassword,
                builder: (context, userConfirmPassword, child) {
                  return TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      labelText: lang.confirmPassword,
                    ),
                    validator: (value) {
                      if (value != profileProvider.userNewPassword) {
                        return lang.validationNewPassword;
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            Selector<ProfileProvider, String>(
              selector: (context, provider) => provider.message,
              shouldRebuild: (previous, next) => true,
              builder: (context, data, child) {
                return Text(
                  data,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    if (userPasswordKey.currentState!.validate()) {
                      if (await authHelper.updatePassword(
                        newPassword: profileProvider.userNewPassword,
                        oldPassword: profileProvider.userOldPassword,
                        token: authenticationProvider.token,
                      )) {
                        profileProvider.message = "Mot de passe modifié";
                      } else {
                        profileProvider.message = "Une erreur est survenue";
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
