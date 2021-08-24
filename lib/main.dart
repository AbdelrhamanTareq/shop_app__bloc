import 'package:flutter/material.dart';
import 'package:shop_app_bloc/helpers/cache_helper.dart';
import 'package:shop_app_bloc/screens/on_boarding_screen.dart';

import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var _token = CacheHelper.getToken('onBoarding') ?? false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _token ? HomeScreen() : OnBoardingScreen(),
    );
  }
}
