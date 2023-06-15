import 'package:count_of_monet/model/helper/AuthHelper.dart';
import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showSignupDialg({
  required BuildContext context,
}) {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  PreferenceProvider preferenceProvider =
      Provider.of<PreferenceProvider>(context, listen: false);
  AuthHelper authHelper = AuthHelper();
  preferenceProvider.setMessage = "";

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lang.signup,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: signupFormKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            lang.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                side: BorderSide(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            height: 60.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value != null) {
                                  preferenceProvider.name = value;
                                }
                                return null;
                              },
                              cursorColor: Color(0xffffd100),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                // color: theme.disabledColor,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xffffd100),
                                ),
                                hintText: lang.yourUsername,
                                hintStyle: TextStyle(
                                  // color: theme.canvasColor,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            lang.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                side: BorderSide(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            height: 60.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value != null) {
                                  preferenceProvider.email = value;
                                }
                                return null;
                              },
                              cursorColor: Color(0xffffd100),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                // color: theme.disabledColor,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xffffd100),
                                ),
                                hintText: lang.yourEmail,
                                hintStyle: TextStyle(
                                  // color: theme.canvasColor,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            lang.password,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                side: BorderSide(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            height: 60.0,
                            child: Selector<PreferenceProvider, bool>(
                                selector: (context, provider) =>
                                    provider.isVisible,
                                builder: (context, data, child) {
                                  return TextFormField(
                                    obscureText: !preferenceProvider.isVisible,
                                    validator: (value) {
                                      if (value != null) {
                                        preferenceProvider.password = value;
                                      }
                                      return null;
                                    },
                                    cursorColor: Color(0xffffd100),
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      // color: theme.disabledColor,
                                      fontFamily: 'OpenSans',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color(0xffffd100),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          preferenceProvider.isVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        color: Colors.grey.shade800,
                                        onPressed: () {
                                          preferenceProvider.isVisible =
                                              !preferenceProvider.isVisible;
                                        },
                                      ),
                                      hintText: lang.password,
                                      hintStyle: TextStyle(
                                        // color: theme.canvasColor,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            lang.verifyPassword,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                side: BorderSide(
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            height: 60.0,
                            child: Selector<PreferenceProvider, bool>(
                                selector: (context, provider) =>
                                    provider.isVisible,
                                builder: (context, data, child) {
                                  return TextFormField(
                                    obscureText: !preferenceProvider.isVisible,
                                    validator: (value) {
                                      if (value != null) {
                                        preferenceProvider.password2 = value;
                                      }
                                      return null;
                                    },
                                    cursorColor: Color(0xffffd100),
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      // color: theme.disabledColor,
                                      fontFamily: 'OpenSans',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color(0xffffd100),
                                      ),
                                      hintText: lang.verifyPassword,
                                      hintStyle: TextStyle(
                                        // color: theme.canvasColor,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Selector<PreferenceProvider, String>(
                          selector: (context, provider) => provider.message,
                          builder: (context, data, child) {
                            return Text(
                              data,
                              // style: TextStyle(
                              //   color: Colors.red,
                              // ),
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (signupFormKey.currentState!.validate()) {
                            if (preferenceProvider.password !=
                                preferenceProvider.password2) {
                              preferenceProvider.message =
                                  lang.passwordDifferent;
                            } else {
                              if (await authHelper.signup(
                                email: preferenceProvider.email,
                                name: preferenceProvider.name,
                                password: preferenceProvider.password,
                              )) {
                                preferenceProvider.message =
                                    lang.accountCreated;
                              } else {
                                preferenceProvider.message = lang.errorOccur;
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onPrimary: Color(0xffffd100),
                        ),
                        child: Text(
                          lang.signup,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
