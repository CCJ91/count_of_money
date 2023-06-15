import 'package:count_of_monet/provider/PreferenceProvider.dart';
import 'package:count_of_monet/utils/languages/Languages.dart';
import 'package:count_of_monet/views/ProfilePage/Widgets/LogoutButton.dart';
import 'package:count_of_monet/views/profilePage/Widgets/InformationForm.dart';
import 'package:count_of_monet/views/profilePage/Widgets/LanguageSelect.dart';
import 'package:count_of_monet/views/profilePage/Widgets/PasswordForm.dart';
import 'package:count_of_monet/views/profilePage/Widgets/ProfileCard.dart';
import 'package:count_of_monet/views/profilePage/Widgets/ThemeSelect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController1 = ScrollController();
    ScrollController scrollController2 = ScrollController();
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    return Column(
      children: [
        ProfileCard(),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: ColoredBox(
              color: preferenceProvider.themeMode == ThemeMode.light
                  ? Colors.white
                  : Colors.grey.shade500,
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xFFffd100),
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(text: lang.profile),
                      Tab(text: lang.settings),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [InformationForm(), PasswordForm()],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: scrollController2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LanguageSelect(),
                                ThemeSelect(),
                                LogoutButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
