import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/models/change_favorite_model.dart';
import 'package:shop_app_bloc/models/product_details_model.dart';
import 'package:shop_app_bloc/shared/component.dart';

import '/bloc/states/home_state.dart';
import '/helpers/dio_helper.dart';
import '/models/home_model.dart';
import '/screens/category_screen.dart';
import '/screens/favorite_screen.dart';
import '/screens/products_screen.dart';
import '/screens/setting_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  Map<int, bool> favorites = {};
  Future<HomeModel?> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final response = await DioHelper.getData(
        endPoint: 'home',
      );

      homeModel = HomeModel.fromJson(response.data);

      print(homeModel!.data!.products[0].name);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });

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

  Future<ChangeFavorite?> addOrRemvoeFavorites({required int productId}) async {
    ChangeFavorite? changeFavoriteModel;
    favorites[productId] = !favorites[productId]!;
    emit(HomeAddOrRemoveFavoreitesChangeState());
    try {
      final response = await DioHelper.postData(
          endPoint: 'favorites',
          data: {
            'product_id': productId,
          },
          token: token);
      changeFavoriteModel = ChangeFavorite.fromJson(response.data);
      print(response.data);

      if (!changeFavoriteModel.status!) {
        favorites[productId] = !favorites[productId]!;
      }

      emit(HomeAddOrRemoveFavoreitesSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(HomeAddOrRemoveFavoreitesErrorState());
    }
    return changeFavoriteModel;
  }

  Future<ProductModel?> getProductDetails(id) async {
    ProductModel? productModel;
    emit(GetProductDetailsLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'product/$id');
      productModel = ProductModel.fromJson(response.data);
      emit(GetProductDetailSuccsesState());
      print('productModel $productModel');
    } catch (error) {
      emit(GetProductDetailsErrorState());
      print(error);
    }
    return productModel;
  }
}
