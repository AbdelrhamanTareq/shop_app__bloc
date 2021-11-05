import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

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
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, 'change_pass_heading'),
                style: TextStyle(color: Colors.black)),
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
                            hintText: getTranslated(context, 'pass_hint_text'),
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
                                return getTranslated(
                                    context, 'pass_error_text');
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFiled(
                          controller: _newPassController,
                          hintText:
                              getTranslated(context, 'new_pass_hint_text'),
                          preixIcon: Icon(Icons.vpn_key),
                          validatorFunction: (String? val) {
                            if (val!.length < 6) {
                              return getTranslated(
                                  context, 'new_pass_error_text');
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
                          hintText:
                              getTranslated(context, 'confirm_pass_hint_text'),
                          preixIcon: Icon(Icons.vpn_key),
                          validatorFunction: (String? val) {
                            if (val! != _newPassController.text) {
                              return getTranslated(
                                  context, 'confirm_pass_error_text');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildButton(
                          context,
                          function: () => _changePassword(
                            context,
                            oldPass: _passController.text,
                            newPass: _newPassController.text,
                          ),
                          child: (state is ChangePasswordLoadingState)
                              ? buildProgressIndicator(isMainColor: false)
                              : buildButtonText(
                                  text: getTranslated(
                                      context, 'change_pass_button_text'),
                                ),
                        ),
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
