import 'package:flutter/material.dart';
import 'package:shop_app_bloc/screens/change_password_screen.dart';
import 'package:shop_app_bloc/screens/edit_profile_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          buildHeading('Account', context, Icons.account_balance_rounded),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              // color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildIconListTile(context, 'Edit Profile', () {
                    navTo(context, EditProfileScreen());
                  }),
                  buildIconListTile(
                    context,
                    'Change Password',
                    () {
                      navTo(context, ChangePasswordScreen());
                    },
                  ),
                  buildIconListTile(context, 'Privacy', () {}),
                ],
              ),
            ),
          ),
          buildHeading('Notification', context, Icons.notifications),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildSwitchListTile(
                    context,
                    'Notification',
                  ),
                  buildSwitchListTile(
                    context,
                    'App notification',
                  ),
                ],
              ),
            ),
          ),
          buildHeading('More', context, Icons.more_outlined),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  buildIconListTile(context, 'Language', () {}),
                  buildIconListTile(context, 'Country', () {}),
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
        color: Colors.black,
      ),
      SizedBox(width: 8),
      Container(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.start,
        ),
        // width: double.infinity,
      ),
    ]),
  );
}

ListTile buildSwitchListTile(BuildContext context, String text) {
  return ListTile(
    leading: Text(
      text,
      style: TextStyle(color: Colors.grey),
    ),
    trailing: Switch(
        value: true,
        // CacheHelper.getMode('mode'),
        onChanged: (state) {}),
  );
}
