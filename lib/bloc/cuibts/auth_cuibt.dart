import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/states/auth_state.dart';
import '/helpers/cache_helper.dart';
import '/helpers/dio_helper.dart';
import '/models/login_model.dart';

class AuthCuibt extends Cubit<AppAuthState> {
  AuthCuibt() : super(AppAuthInitialState());

  static AuthCuibt get(context) => BlocProvider.of(context);

  bool isVisible = false;

  LoginModel? loginModel;

  void changeVisibality() {
    isVisible = !isVisible;
    emit(AppLoginChangeSuffixIconState());
  }

  Future<LoginModel?> login(
      {required String email, required String pass}) async {
    emit(AppLoginLoadingState());
    // LoginModel? loginModel;
    try {
      final response = await DioHelper.postData(endPoint: 'login', data: {
        'email': email,
        'password': pass,
      });
      print('response ${response.data}');
      loginModel = LoginModel.fromJson(response.data);
      // print('loginModel ${loginModel!.data!.token}');
      // print('tt ${loginModel!.data!}');
      // CacheHelper.setToken('token', loginModel!.data!.token!);

      emit(AppLoginSuccuessState(loginModel!));
      // return loginModel;
    } catch (error) {
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    }
    return loginModel;
  }

  Future register({
    required String email,
    required String pass,
    required String username,
    required String phone,
  }) async {
    emit(AppRegisterLoadingState());

    try {
      final response = await DioHelper.postData(endPoint: 'register', data: {
        'email': email,
        'password': pass,
        'name': username,
        'phone': phone
      });
      print(response.data);
      loginModel = LoginModel.fromJson(response.data);
      CacheHelper.setToken('token', loginModel!.data!.token!);
      emit(AppRegisterSuccuessState(loginModel!));
    } catch (error) {
      print(error.toString());
      emit(AppRegisterErrorState(error.toString()));
    }
  }
}
