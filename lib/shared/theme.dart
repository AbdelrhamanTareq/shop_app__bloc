import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.redAccent,
  primarySwatch: Colors.red,
  accentColor: Colors.blueAccent,
  brightness: Brightness.light,
  canvasColor: Colors.white,

  ///////////////// App Bar //////////////////////
  appBarTheme: AppBarTheme(
    elevation: 10,
    backgroundColor: Colors.white,
  ),

  ///////////////// Text //////////////////////
  // textTheme: TextTheme(),
);
