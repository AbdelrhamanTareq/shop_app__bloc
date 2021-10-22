import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/helpers/cache_helper.dart';

final String token = CacheHelper.getToken('token') ?? '';

void navAndFininsh(context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (ctx) => screen),
    (route) => false,
  );
}

void navTo(context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (ctx) => screen),
  );
}

TextFormField buildTextFiled({
  required TextEditingController controller,
  required String hintText,
  required Widget preixIcon,
  required String? Function(String? val)? validatorFunction,
  required TextInputType keyboardType,
  bool obscureText = false,
  Widget? suffixIcon,
  void Function(String? val)? onFieldSubmittedFunction,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: preixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: validatorFunction,
    obscureText: obscureText,
    onFieldSubmitted: onFieldSubmittedFunction,
  );
}

void configLoading() {
  EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.redAccent
    ..backgroundColor = Colors.redAccent
    ..indicatorColor = Colors.redAccent
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

Center buildProgressIndicator({bool isMainColor = true}) => Center(
      child: CircularProgressIndicator(
        color: isMainColor ? Colors.redAccent : Colors.amber,
      ),
    );

Container buildButton(context,
        {required Function function, required Widget child}) =>
    Container(
      width: double.infinity,
      height: 70,
      color: Theme.of(context).primaryColor,
      child: TextButton(
          onPressed: () async {
            function();
          },
          child: child
          //  (state is EditProfileLoadingState)
          //     ? buildProgressIndicator(isMainColor: false)
          //     : Text(
          //         'Edit',
          //         style: TextStyle(color: Colors.white),
          //       ),
          ),
    );
Text buildButtonText({required String text}) => Text(
      text,
      style: TextStyle(color: Colors.white),
    );

    // Container(
    //                       width: double.infinity,
    //                       height: 70,
    //                       color: Theme.of(context).primaryColor,
    //                       child: TextButton(
    //                         onPressed: () async {
    //                           _changePassword(context,
    //                               oldPass: _passController.text,
    //                               newPass: _newPassController.text);
    //                         },
    //                         child: (state is ChangePasswordLoadingState)
    //                             ? buildProgressIndicator(isMainColor: false)
    //                             : Text(
    //                                 'Change Password',
    //                                 style: TextStyle(color: Colors.white),
    //                               ),
    //                       ),
    //                     )
