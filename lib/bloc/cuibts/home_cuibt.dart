import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/states/home_state.dart';
import 'package:shop_app_bloc/helpers/dio_helper.dart';
import 'package:shop_app_bloc/models/home_model.dart';
import 'package:shop_app_bloc/models/login_model.dart';
import 'package:shop_app_bloc/screens/category_screen.dart';
import 'package:shop_app_bloc/screens/favorite_screen.dart';
import 'package:shop_app_bloc/screens/products_screen.dart';
import 'package:shop_app_bloc/screens/home_screen.dart';
import 'package:shop_app_bloc/screens/setting_screen.dart';
import 'package:shop_app_bloc/shared/component.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  Future<HomeModel?> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final response = await DioHelper.getData(
        endPoint: 'home',
      );

      homeModel = HomeModel.fromJson(response.data);
      print(homeModel!.data!.products[0].name);

      emit(HomeSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(HomeErorrState(error.toString()));
    }
    return homeModel;
  }

  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeChangeNavBarState());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
}
