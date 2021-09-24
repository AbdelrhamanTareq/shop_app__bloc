import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_bloc/bloc/cuibts/category_cuibt.dart';
import 'package:shop_app_bloc/shared/bloc_observer.dart';

import './helpers/dio_helper.dart';
import '/bloc/cuibts/home_cuibt.dart';
import '/helpers/cache_helper.dart';
import '/screens/login_screen.dart';
import '/screens/on_boarding_screen.dart';
import '/screens/home_screen.dart';
import '/shared/component.dart';
import '/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();

  configLoading();
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
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getCategoryData()
            ..getHomeData(),
          lazy: false,
        ),
        // BlocProvider(
        //   create: (context) => CategoryCubit()..getCategoryData(),
        //   lazy: false,
        // ),
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: _onBoarding
            ? ((token != '') ? HomeScreen() : LoginScreen())
            : OnBoardingScreen()
        //  _onBoarding ? ((_token != null)) ? HomeScreen():
        //  (_token != null) ? HomeScreen() : LoginScreen()
        // _onBoarding ? HomeScreen() : OnBoardingScreen()
        ,
      ),
    );
  }
}
