import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
