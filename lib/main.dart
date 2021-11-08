import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_app_bloc/localiziation/app_localization.dart';

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
            ..getCategoryData()
            ..getCartData()
            ..getFavoriteData(),
        ),
        // BlocProvider(

        BlocProvider(
          create: (BuildContext context) => AuthCuibt()..getProfileData(),
          lazy: false,
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('cart q ${HomeCubit.get(context).cartQuantity}');
          return MaterialApp(
            title: 'Shop App',
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: HomeCubit.get(context).isDark ? darkTheme : lightTheme,
            home: _onBoarding
                ? ((token != '') ? HomeScreen() : LoginScreen())
                : OnBoardingScreen(),

            //////////////////////////////////////////////////////////
            ////////            LOCALIZATION /////////////////////////
            locale: isArabic1
                // HomeCubit.get(context).isArabic
                ? Locale('ar')
                : Locale('en'),
            localizationsDelegates: [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],
            // localeResolutionCallback: (deviceLanguage, supportedLocales) {
            //   for (var locale in supportedLocales) {
            //     if (locale.languageCode == deviceLanguage!.languageCode &&
            //         locale.countryCode == deviceLanguage.countryCode) {
            //       return deviceLanguage;
            //     }
            //   }
            //   return supportedLocales.first;
            // },
          );
        },
      ),
    );
  }
}
