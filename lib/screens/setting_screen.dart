import 'package:flutter/material.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/bloc/cuibts/home_cuibt.dart';
import '/screens/change_password_screen.dart';
import '/screens/edit_profile_screen.dart';
import '/screens/privacy_screen.dart';
import '/shared/component.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          buildHeading(getTranslated(context, 'setting_account_heading'),
              context, Icons.account_balance_rounded),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              // color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildIconListTile(
                      context, getTranslated(context, 'setting_edit_profile'),
                      () {
                    navTo(context, EditProfileScreen());
                  }),
                  buildIconListTile(
                    context,
                    getTranslated(context, 'setting_change_password'),
                    () {
                      navTo(context, ChangePasswordScreen());
                    },
                  ),
                  buildIconListTile(
                      context, getTranslated(context, 'setting_privacy'), () {
                    navTo(context, PrivacyScreen());
                  }),
                ],
              ),
            ),
          ),
          buildHeading(getTranslated(context, 'setting_account_notification'),
              context, Icons.notifications),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildSwitchListTile(
                      context,
                      getTranslated(context, 'setting_change_password'),
                      HomeCubit.get(context).isDark, (state) {
                    HomeCubit.get(context).darkMode(state);
                  }),
                  buildSwitchListTile(
                    context,
                    getTranslated(context, 'setting_change_language'),
                    // false,
                    HomeCubit.get(context).isArabic,
                    (state) {
                      print(state);
                      HomeCubit.get(context).changeLang(state);
                    },
                  ),
                  buildSwitchListTile(
                      context,
                      getTranslated(context, 'setting_app_notification'),
                      false,
                      () {}),
                ],
              ),
            ),
          ),
          buildHeading(getTranslated(context, 'setting_more_heading'), context,
              Icons.more_outlined),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildIconListTile(context,
                      getTranslated(context, 'setting_language'), () {}),
                  buildIconListTile(context,
                      getTranslated(context, 'setting_country'), () {}),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: buildHeading('LOGOUT', context, Icons.logout),
          //   ),
          // ),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.grey[200],
    );
  }
}

ListTile buildIconListTile(
    BuildContext context, String text, Function function) {
  return ListTile(
    leading: Text(text,
        style: TextStyle(
          color: Colors.grey,
        )),
    trailing: IconButton(
      onPressed: () {
        function();
      },
      icon: Icon(
        Icons.arrow_right,
        color: Theme.of(context).iconTheme.copyWith(color: Colors.grey).color,
      ),
    ),
  );
}

Padding buildHeading(String text, context, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Row(children: [
      Icon(
        icon,
        // color: Colors.black,
      ),
      SizedBox(width: 8),
      Container(
        child: Text(
          text,
          style: TextStyle(
            color: (Theme.of(context).dividerColor),
            fontSize: 16,
          ),
          textAlign: TextAlign.start,
        ),
        // width: double.infinity,
      ),
    ]),
  );
}

ListTile buildSwitchListTile(
    BuildContext context, String text, bool value, Function function) {
  return ListTile(
    leading: Text(
      text,
      style: TextStyle(color: Colors.grey),
    ),
    trailing: Switch(
        value: value,
        // CacheHelper.getMode('mode'),
        onChanged: (state) {
          function(state);
        }),
  );
}
