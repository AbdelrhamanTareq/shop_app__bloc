import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/cuibts/home_cuibt.dart';

import 'package:shop_app_bloc/helpers/cache_helper.dart';
import 'package:shop_app_bloc/screens/login_screen.dart';
import 'package:shop_app_bloc/screens/on_boarding_screen.dart';
import 'package:shop_app_bloc/screens/home_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';
import 'package:shop_app_bloc/shared/theme.dart';

import 'screens/products_screen.dart';
import 'helpers/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool _onBoarding = CacheHelper.getOnboarding('onBoarding') ?? false;

  // final String? _token = CacheHelper.getToken('token') ?? null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(token);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getHomeData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: _onBoarding
            ? ((token != null) ? HomeScreen() : LoginScreen())
            : OnBoardingScreen()
        //  _onBoarding ? ((_token != null)) ? HomeScreen():
        //  (_token != null) ? HomeScreen() : LoginScreen()
        // _onBoarding ? HomeScreen() : OnBoardingScreen()
        ,
      ),
    );
  }
}
