import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/bloc/cuibts/auth_cuibt.dart';
import '/bloc/states/home_state.dart';
import '/shared/bloc_observer.dart';
import './helpers/dio_helper.dart';
import '/bloc/cuibts/home_cuibt.dart';
import '/helpers/cache_helper.dart';
import '/screens/login_screen.dart';
import '/screens/on_boarding_screen.dart';
import '/screens/home_screen.dart';
import '/shared/component.dart';
import '/shared/theme.dart';

//AIzaSyAYn6QIqi6Skqpwy7AOs9K8X3uTRmgTGdk map api
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
        BlocProvider<HomeCubit>.value(
          value: HomeCubit()
            ..getHomeData()
            ..dummyFuckingFunction()
            ..getCategoryData()
            ..getCartData()
            ..getFavoriteData(),
        ),
        // BlocProvider(
        //   create: (BuildContext context) => HomeCubit()
        //     // ..getCategoryData()
        //     ..getHomeData()
        //   // ..getFavoriteData()
        //   // ..getCartData()
        //   ,
        //   lazy: false,
        // ),
        BlocProvider(
          create: (BuildContext context) => AuthCuibt()..getProfileData(),
          lazy: false,
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('dummy ${HomeCubit.get(context).dummy}');
          return MaterialApp(
            title: 'Shop App',
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: HomeCubit.get(context).isDark ? darkTheme : lightTheme,
            home: _onBoarding
                ? ((token != '') ? HomeScreen() : LoginScreen())
                : OnBoardingScreen()
            //  _onBoarding ? ((_token != null)) ? HomeScreen():
            //  (_token != null) ? HomeScreen() : LoginScreen()
            // _onBoarding ? HomeScreen() : OnBoardingScreen()
            ,
          );
        },
      ),
    );
  }
}
