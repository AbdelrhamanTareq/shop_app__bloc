import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/bloc/states/category_states.dart';
import 'package:shop_app_bloc/helpers/dio_helper.dart';
import 'package:shop_app_bloc/models/category_model.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoreyModel? categoreyModel;
  Future<CategoreyModel?> getCategoryData() async {
    emit(CategoryLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'categories');
      categoreyModel = CategoreyModel.fromJson(response.data);
      print(categoreyModel!.data!.dataModel![0].name);
      print('object');
      emit(CategorySucsessState());
      // print('abcdef    ${response.data}');
    } catch (error) {
      emit(CategoryErorrState());
      print(error.toString());
    }
    return categoreyModel;
  }

  funfun(x) {
    print(x);
  }
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

