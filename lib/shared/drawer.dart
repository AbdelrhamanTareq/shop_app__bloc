import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_bloc/bloc/cuibts/auth_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/auth_state.dart';
import 'package:shop_app_bloc/helpers/cache_helper.dart';
import 'package:shop_app_bloc/screens/login_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCuibt, AppAuthState>(
      listener: (context, state) {
        if (state is LogoutSuccuessState) {
          Fluttertoast.showToast(
              msg: state.data['message'], backgroundColor: Colors.green);
        }
      },
      builder: (context, state) {
        final _profileData = AuthCuibt.get(context).profileModel;
        if (_profileData == null || state is GetProfileLoadingState) {
          return buildProgressIndicator();
        }
        return Drawer(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage: NetworkImage(_profileData.data!.image!),
                  ),
                  title: Text('${_profileData.data!.name}'),
                  subtitle: Text('${_profileData.data!.email}'),
                ),
                SizedBox(
                  height: 50,
                ),
                buildListTile(
                  icon: Icons.note_add,
                  text: 'My Order',
                  function: () {},
                ),
                buildListTile(
                  icon: Icons.note_add,
                  text: 'My Order',
                  function: () {},
                ),
                buildListTile(
                  icon: Icons.note_add,
                  text: 'My Order',
                  function: () {},
                ),
                buildListTile(
                  icon: Icons.note_add,
                  text: 'My Order',
                  function: () {},
                ),
                buildListTile(
                  icon: Icons.note_add,
                  text: 'My Order',
                  function: () {},
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: buildListTile(
                    icon: Icons.logout,
                    text: 'Logout',
                    function: () async {
                      AuthCuibt.get(context).logout().then((value) {
                        navAndFininsh(context, LoginScreen());
                        CacheHelper.deletePref('token');
                      });
                    },
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile buildListTile(
      {required Function function,
      required IconData icon,
      required String text}) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
