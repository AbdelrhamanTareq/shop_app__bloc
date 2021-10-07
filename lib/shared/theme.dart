import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.redAccent,
  primarySwatch: Colors.red,
  accentColor: Colors.amber,
  brightness: Brightness.light,
  canvasColor: Colors.white,
  fontFamily: 'Cairo',

  ///////////////// App Bar //////////////////////
  appBarTheme: AppBarTheme(
    elevation: 10,
    backgroundColor: Colors.white,
  ),

  ///////////////// Text //////////////////////
  textTheme: TextTheme(
    headline4: TextStyle(
        fontSize: 26, fontWeight: FontWeight.w700, color: Colors.redAccent),
    headline6: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w200, color: Colors.grey),
    bodyText1: TextStyle(color: Colors.redAccent),
    bodyText2: TextStyle(color: Colors.grey),
  ),
  ///////////////// Botton nav Bar //////////////////////
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 10,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.redAccent,
  ),
);
