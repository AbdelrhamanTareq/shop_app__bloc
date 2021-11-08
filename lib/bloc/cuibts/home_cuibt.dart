import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/helpers/cache_helper.dart';
import '/models/cart_model.dart';
import '/models/category_details_model.dart';
import '/models/category_model.dart';
import '/models/change_favorite_model.dart';
import '/models/favorite_model.dart';
import '/models/product_details_model.dart';
import '/models/seacrh_model.dart';
import '/shared/component.dart';
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

  Map<int, bool> inCart = {};
  Map<int, bool> favorites = {};

  HomeModel? homeModel;

  Future<HomeModel?> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final response = await DioHelper.getData(
        endPoint: 'home',
      );

      homeModel = HomeModel.fromJson(response.data);

      print('abcdef${homeModel!.data!.products[0].name}');

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      homeModel!.data!.products.forEach((element) {
        inCart.addAll({element.id!: element.inCart!});
      });

      emit(HomeSuccsesState());
    } on DioError catch (e) {
      if (DioErrorType.connectTimeout == e.type ||
          DioErrorType.receiveTimeout == e.type) {
        print('dsfsdfsdfaerwrewrfskdfsdf');
      } else {
        Fluttertoast.showToast(
            msg: 'Check your connection',
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
      }
      //     if (DioErrorType. == e.type ||
      //     DioErrorType.CONNECT_TIMEOUT == e.type) {
      //   throw CommunicationTimeoutException(
      //       "Server is not reachable. Please verify your internet connection and try again");
      // } else if (DioErrorType.RESPONSE == e.type) {
      //   // 4xx 5xx response
      //   // throw exception...
      // } else if (DioErrorType.DEFAULT == e.type) {
      //      if (e.message.contains('SocketException')) {
      //        throw CommunicationTimeoutException('blabla');
      //      }
      // } else {
      //       throw CommunicationException("Problem connecting to the server. Please try again.");
      print(e.toString());
      emit(HomeErorrState(e.toString()));
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

  Future deleteFavorite(
    int id,
  ) async {
    emit(DeleteFavoriteLoadingState());
    favoriteModel!.data!.dataModel!.removeWhere((element) => element.id == id);
    try {
      final response = await DioHelper.deleteData(endPoint: 'favorites/$id');
      print(response.data);

      // favoriteModel = FavoriteModel.fromJson(response.data);

      emit(DeleteFavoriteSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(DeleteFavoriteErrorState(error.toString()));
    }
  }

  SeacrhModel? seacrhModel;
  Future<SeacrhModel?> search(String text) async {
    emit(SearchLoadingState());
    try {
      final response = await DioHelper.postData(
          endPoint: 'products/search', data: {'text': text});
      seacrhModel = SeacrhModel.fromJson(response.data);
      print('xxxxxxxxx  ${seacrhModel!.data!.dataModel[0].images}');

      emit(SearchSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    }
    return seacrhModel;
  }

  CartModel? cartModel;

  Map<int, int> cartQuantity = {};
  Future<CartModel?> getCartData() async {
    emit(GetCartDataLoadingState());

    try {
      final response = await DioHelper.getData(endPoint: 'carts');
      cartModel = CartModel.fromJson(response.data);
      cartModel!.data!.cartItem!.forEach((element) {
        cartQuantity.addAll({element.id!: element.quantity!});
      });
      print('xyxyxyxyx  ${cartModel!.data!.cartItem!.length}');

      emit(GetCartDataSuccsesState());
    } catch (error) {
      print(error.toString());
      emit(GetCartDataErrorState(error.toString()));
    }
    return cartModel;
  }

  Future addOrRemvoeCart({required int productId}) async {
    inCart[productId] = !inCart[productId]!;
    if (inCart[productId] = true) {
      cartModel!.data!.cartItem!
          .removeWhere((element) => element.product!.id == productId);
    }
    // cartModel!.data!.cartItem!.contains()
    emit(AddOrRemoveCartLoadingState());
    try {
      final response = await DioHelper.postData(
        endPoint: 'carts',
        data: {
          'product_id': productId,
        },
        token: token,
      );
      // changeFavoriteModel = ChangeFavorite.fromJson(response.data);
      print(response.data);

      if (!response.data['status']) {
        inCart[productId] = !inCart[productId]!;
      }
      print(inCart);
      getCartData();

      emit(AddOrRemoveCartSuccsesState(response.data));
    } catch (error) {
      print(error.toString());
      emit(AddOrRemoveCartErrorState(error.toString()));
    }
  }

  Future updateCart({
    required int productId,
    required int quantity,
    bool isAdd = false,
  }) async {
    emit(AddOrRemoveCartLoadingState());

    isAdd
        ? cartQuantity[productId] = cartQuantity[productId]! + 1
        : cartQuantity[productId] = cartQuantity[productId]! - 1;
    print('a7a ${cartQuantity[productId]!}');
    print('2a7a ${cartQuantity}');
    try {
      final response = await DioHelper.updateData(
        endPoint: 'carts/$productId',
        data: {
          'quantity': quantity,
        },
      );
      // changeFavoriteModel = ChangeFavorite.fromJson(response.data);
      print(response.data);

      // getCartData();
      if (response.statusCode != 200 || !cartModel!.status!) {
        isAdd
            ? cartQuantity[productId] = cartQuantity[productId]! - 1
            : cartQuantity[productId] = cartQuantity[productId]! + 1;
      }
      emit(AddOrRemoveCartSuccsesState(response.data));
    } catch (error) {
      print(error.toString());
      emit(AddOrRemoveCartErrorState(error.toString()));
    }
  }

  bool isDark = CacheHelper.getPref('darkMode') ?? false;
  void darkMode(bool state) {
    isDark = state;
    CacheHelper.setPref('darkMode', state);
    emit(SwitchDarkMode());
  }

  // bool isArabic = CacheHelper.getPref('Arabic') ?? false;
  changeLang(bool state) {
    isArabic1 = state;
    CacheHelper.setPref('Arabic', state);
    emit(SwitchLanguage());
  }
}
