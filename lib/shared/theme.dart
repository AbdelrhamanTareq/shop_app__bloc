import 'package:flutter/material.dart';

// final darkTheme = Theme.of(context).brightness == Brightness.dark;

final lightTheme = ThemeData(
  primaryColor: Colors.redAccent,
  primarySwatch: Colors.red,
  accentColor: Colors.amber,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  canvasColor: Colors.white,
  buttonColor: Colors.white,
  dividerColor: Colors.black,

  fontFamily: 'Cairo',

  ///////////////// App Bar //////////////////////
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    elevation: 10,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),

  ///////////////// Icon //////////////////////

  iconTheme: IconThemeData(
    color: Colors.black,
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
final darkTheme = ThemeData(
  primaryColor: Colors.redAccent,
  primarySwatch: Colors.red,
  accentColor: Colors.amber,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  canvasColor: Colors.black,
  fontFamily: 'Cairo',
  buttonColor: Colors.white,
  dividerColor: Colors.white,

  ///////////////// App Bar //////////////////////
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    elevation: 10,
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  ///////////////// Icon //////////////////////

  iconTheme: IconThemeData(
    color: Colors.white,
  ),

  ///////////////// Text //////////////////////
  textTheme: TextTheme(
    headline4: TextStyle(
        fontSize: 26, fontWeight: FontWeight.w700, color: Colors.redAccent),
    headline6: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
    bodyText1: TextStyle(color: Colors.redAccent),
    bodyText2: TextStyle(color: Colors.white),
  ),
  ///////////////// Botton nav Bar //////////////////////
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 10,
    backgroundColor: Colors.black,
    selectedItemColor: Colors.redAccent,
  ),
);
