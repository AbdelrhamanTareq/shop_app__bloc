import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/localiziation/localizatrion_constant.dart';

import '/bloc/cuibts/auth_cuibt.dart';
import '/bloc/states/auth_state.dart';
import '/screens/login_screen.dart';
import '/screens/home_screen.dart';
import '/shared/component.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await AuthCuibt.get(context).register(
          email: _emailController.text,
          pass: _passController.text,
          username: _usernameController.text,
          phone: _phoneController.text);
      navTo(context, HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCuibt(),
      child: BlocConsumer<AuthCuibt, AppAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      getTranslated(context, 'register_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Text(
                      getTranslated(context, 'register_heading'),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextFiled(
                              keyboardType: TextInputType.name,
                              controller: _usernameController,
                              hintText:
                                  getTranslated(context, 'username_hint_text'),
                              preixIcon: Icon(Icons.verified_user),
                              validatorFunction: (String? val) {
                                if (val!.length < 4) {
                                  return getTranslated(
                                      context, 'username_error_text');
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              hintText:
                                  getTranslated(context, 'e-mail_hint_text'),
                              preixIcon: Icon(Icons.email),
                              validatorFunction: (String? val) {
                                if (!val!.contains('@')) {
                                  return getTranslated(
                                      context, 'e-mail_error_text');
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passController,
                              hintText:
                                  getTranslated(context, 'pass_hint_text'),
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
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _confirmPassController,
                              hintText: getTranslated(
                                  context, 'confirm_pass_hint_text'),
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
                                if (val != _passController.text) {
                                  return getTranslated(
                                      context, 'confirm_pass_error_text');
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              hintText:
                                  getTranslated(context, 'phone_hint_text'),
                              preixIcon: Icon(Icons.vpn_key),
                              validatorFunction: (String? val) {
                                if (val!.length < 6) {
                                  return getTranslated(
                                      context, 'phone_error_text');
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          (state is AppRegisterLoadingState)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  // color: Theme.of(context).primaryColor,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    child: Text(
                                      getTranslated(
                                          context, 'register_button_text'),
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor),
                                    ),
                                    onPressed: () {
                                      _submit(context);
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(getTranslated(
                                  context, 'register_have_account')),
                              TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size(1, 1)),
                                  ),
                                  onPressed: () {
                                    navTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    getTranslated(context, 'register_login'),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))
                            ],
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
      ),
    );
  }
}
