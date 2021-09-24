import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/states/category_states.dart';
import 'package:shop_app_bloc/helpers/dio_helper.dart';
import 'package:shop_app_bloc/models/category_details_model.dart';
import 'package:shop_app_bloc/models/category_model.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  // CategoreyModel? categoreyModel;
  // Future<CategoreyModel?> getCategoryData() async {
  //   emit(CategoryLoadingState());
  //   try {
  //     final response = await DioHelper.getData(endPoint: 'categories');
  //     categoreyModel = CategoreyModel.fromJson(response.data);
  //     print(categoreyModel!.data!.dataModel![0].name);
  //     emit(CategorySucsessState());
  //     // print('abcdef    ${response.data}');
  //   } catch (error) {
  //     emit(CategoryErorrState(error.toString()));
  //     print(error.toString());
  //   }
  //   return categoreyModel;
  // }

  // CategoryDetailsModel? categoreyDetailsModel;
  // Future<CategoryDetailsModel?> getCategoryDetails(int id) async {
  //   emit(CategoryDetailsLoadingState());
  //   try {
  //     final response = await DioHelper.getData(endPoint: 'categories/$id');
  //     categoreyDetailsModel = CategoryDetailsModel.fromJson(response.data);
  //     // print('response.data ${response.data}');
  //     // print('object');
  //     print(categoreyDetailsModel!.data!.dataModel![0].images);
  //     emit(CategoryDetailsSucsessState());
  //     // print('abcdef    ${response.data}');
  //   } catch (error) {
  //     emit(CategoryDetailsErorrState(error.toString()));
  //     print(error.toString());
  //   }
  //   return categoreyDetailsModel;
  // }
}


// Future<HomeModel?> getHomeData() async {
//     emit(HomeLoadingState());

//     try {
//       final response = await DioHelper.getData(
//         endPoint: 'home',
//       );

//       homeModel = HomeModel.fromJson(response.data);

//       print(homeModel!.data!.products[0].name);

//       homeModel!.data!.products.forEach((element) {
//         favorites.addAll({element.id!: element.inFavorites!});
//       });

//       emit(HomeSuccsesState());
//     } catch (error) {
//       print(error.toString());
//       emit(HomeErorrState(error.toString()));
//     }
//     return homeModel;
//   }

