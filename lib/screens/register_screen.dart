import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/cuibts/auth_cuibt.dart';
import 'package:shop_app_bloc/bloc/states/auth_state.dart';
import 'package:shop_app_bloc/screens/home_screen.dart';
import 'package:shop_app_bloc/screens/login_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

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
                      'Register',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please register to continue',
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
                              hintText: 'Username',
                              preixIcon: Icon(Icons.verified_user),
                              validatorFunction: (String? val) {
                                if (val!.length < 4) {
                                  return 'Username too short';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              hintText: 'E-mail',
                              preixIcon: Icon(Icons.email),
                              validatorFunction: (String? val) {
                                if (!val!.contains('@')) {
                                  return 'Wrong email';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
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
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _confirmPassController,
                              hintText: 'Confirm Password',
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
                                  return 'Password doesnot matchd';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextFiled(
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              hintText: 'Phone',
                              preixIcon: Icon(Icons.vpn_key),
                              validatorFunction: (String? val) {
                                if (val!.length < 6) {
                                  return 'Phone too short';
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
                                      'Register',
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor),
                                    ),
                                    onPressed: () {
                                      _submit(context);
                                      print('submit');
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('have an account?'),
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
                                    'Login',
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
