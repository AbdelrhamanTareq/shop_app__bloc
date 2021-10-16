import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/bloc/cuibts/auth_cuibt.dart';
import '/bloc/states/auth_state.dart';
import '/shared/component.dart';

class ChangePasswordScreen extends StatelessWidget {
  var _passController = TextEditingController();
  var _newPassController = TextEditingController();
  var _conirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _changePassword(
    context, {
    required String oldPass,
    required String newPass,
  }) async {
    if (_formKey.currentState!.validate()) {
      await AuthCuibt.get(context).changePassword({
        'current_password': oldPass,
        'new_password': newPass,
      }).then((value) => _formKey.currentState!.save());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCuibt, AppAuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        // final _profileData = AuthCuibt.get(context).profileModel;
        if (state is ChangePasswordSuccuessState) {
          Fluttertoast.showToast(
                  msg: state.data['message'],
                  backgroundColor: (state.data['status'] == true)
                      ? Colors.green
                      : Colors.red)
              .then((value) {
            _passController.clear();
            _newPassController.clear();
            _conirmPassController.clear();
          });
          print('ddddd${state.data['message']}');
        }
        return Scaffold(
          appBar: AppBar(
            title:
                Text('Change Password', style: TextStyle(color: Colors.black)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFiled(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passController,
                            hintText: 'Password',
                            preixIcon: Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              icon: Icon(AuthCuibt.get(context).isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                AuthCuibt.get(context).changeVisibality();
                              },
                            ),
                            obscureText: !AuthCuibt.get(context).isVisible,
                            validatorFunction: (String? val) {
                              if (val!.length < 6) {
                                return 'Short password';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _newPassController,
                          hintText: 'New Password',
                          preixIcon: Icon(Icons.vpn_key),
                          validatorFunction: (String? val) {
                            if (val!.length < 6) {
                              return 'Short password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _conirmPassController,
                          hintText: 'Confirm Password',
                          preixIcon: Icon(Icons.vpn_key),
                          validatorFunction: (String? val) {
                            if (val! != _newPassController.text) {
                              return 'Password doesnot matched';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 70,
                          color: Theme.of(context).primaryColor,
                          child: TextButton(
                            onPressed: () async {
                              _changePassword(context,
                                  oldPass: _passController.text,
                                  newPass: _newPassController.text);
                            },
                            child: (state is ChangePasswordLoadingState)
                                ? buildProgressIndicator(isMainColor: false)
                                : Text(
                                    'Change Password',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
