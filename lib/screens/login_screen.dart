import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/bloc/cuibts/auth_cuibt.dart';
import '/bloc/states/auth_state.dart';
import '/helpers/cache_helper.dart';
import '/models/login_model.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/shared/component.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(context) async {
    LoginModel? _loginModel;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _loginModel = await AuthCuibt.get(context)
          .login(email: _emailController.text, pass: _passController.text);
      // await CacheHelper.setToken('token', _loginModel!.data!.token!);
      // navAndFininsh(context, HomeScreen());
      print('asdasd $_loginModel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCuibt(),
      child: BlocConsumer<AuthCuibt, AppAuthState>(
        listener: (context, state) {
          if (state is AppLoginSuccuessState) {
            if (state.loginModel.status!) {
              CacheHelper.setToken('token', state.loginModel.data!.token!)
                  .then((value) => {navAndFininsh(context, HomeScreen())});
            } else {
              Fluttertoast.showToast(
                msg: state.loginModel.message!,
                backgroundColor: Colors.red,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
                timeInSecForIosWeb: 5,
                textColor: Colors.white,
              );
            }
          }
        },
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
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please sign in to continue',
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
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              hintText: 'E-mail',
                              preixIcon: Icon(Icons.email),
                              validatorFunction: (val) {
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
                              validatorFunction: (val) {
                                if (val!.length < 6) {
                                  return 'Short password';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          (state is AppLoginLoadingState)
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
                                      'Login',
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor),
                                    ),
                                    onPressed: () {
                                      // _submit(context);
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
                              Text('Don\'t have an account?'),
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
                                    navTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'Register',
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
