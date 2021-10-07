import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_bloc/helpers/cache_helper.dart';

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

Center buildProgressIndicator() => Center(
      child: CircularProgressIndicator(),
    );
