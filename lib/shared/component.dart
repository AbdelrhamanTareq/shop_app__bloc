import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navAndFininsh(context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (ctx) => screen),
    (route) => false,
  );
}
