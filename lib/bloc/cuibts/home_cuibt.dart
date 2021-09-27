import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/models/category_details_model.dart';
import 'package:shop_app_bloc/models/category_model.dart';
import 'package:shop_app_bloc/models/change_favorite_model.dart';
import 'package:shop_app_bloc/models/favorite_model.dart';
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
      // print(response.data);

      if (!changeFavoriteModel.status!) {
        favorites[productId] = !favorites[productId]!;
      }
      print(favorites);
      getFavoriteData();
      // deleteFavorite()
      emit(HomeAddOrRemoveFavoreitesSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(HomeAddOrRemoveFavoreitesErrorState());
    }
    return changeFavoriteModel;
  }

  ProductModel? productModel;
  Future<ProductModel?> getProductDetails(id) async {
    emit(GetProductDetailsLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'products/$id');
      productModel = ProductModel.fromJson(response.data);
      emit(GetProductDetailSuccsesState());
      print('productModel $productModel');
    } catch (error) {
      emit(GetProductDetailsErrorState());
      print(error);
    }
    return productModel;
  }

  CategoreyModel? categoreyModel;
  Future<CategoreyModel?> getCategoryData() async {
    emit(GetCategoryLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'categories');
      categoreyModel = CategoreyModel.fromJson(response.data);
      print(categoreyModel!.data!.dataModel![0].name);
      emit(GetCategorySuccsesState());
      // print('abcdef    ${response.data}');
    } catch (error) {
      emit(GetCategoryErorrState());
      print(error.toString());
    }
    return categoreyModel;
  }

  CategoryDetailsModel? categoreyDetailsModel;
  Future<CategoryDetailsModel?> getCategoryDetails(int id) async {
    emit(GetCategoryDetailsLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'categories/$id');
      categoreyDetailsModel = CategoryDetailsModel.fromJson(response.data);

      print(categoreyDetailsModel!.data!.dataModel![0].images);
      emit(GetCategoryDetailsSuccsesState());
    } catch (error) {
      emit(GetCategoryDetailsErrorState());
      print(error.toString());
    }
    return categoreyDetailsModel;
  }

  FavoriteModel? favoriteModel;
  Future<FavoriteModel?> getFavoriteData() async {
    emit(GetFavoriteLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'favorites');
      favoriteModel = FavoriteModel.fromJson(response.data);
      print(favoriteModel!.data!.dataModel![0].products!.name);
      emit(GetFavoriteSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(GetFavoriteErrorState(error.toString()));
    }
    return favoriteModel;
  }

  Future deleteFavorite(int id, int productId) async {
    emit(DeleteFavoriteLoadingState());
    try {
      final response = await DioHelper.deleteData(endPoint: 'favorites/$id');
      print(response.data);
      // await getFavoriteData();
      // favoriteModel = FavoriteModel.fromJson(response.data);
      // print(favoriteModel!.data!.dataModel![0].products!.name);

      emit(DeleteFavoriteSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(DeleteFavoriteErrorState(error.toString()));
    }
    // addOrRemvoeFavorites(productId: productId);
  }
}
