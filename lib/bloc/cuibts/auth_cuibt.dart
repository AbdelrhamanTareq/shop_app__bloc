import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_bloc/models/profile_model.dart';
import 'package:shop_app_bloc/shared/component.dart';

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

  ProfileModel? profileModel;
  Future<ProfileModel?> getProfileData() async {
    emit(GetProfileLoadingState());
    try {
      final response = await DioHelper.getData(endPoint: 'profile');
      profileModel = ProfileModel.fromJson(response.data);
      print(profileModel!.message);
      emit(GetProfileSuccuessState(profileModel!));
    } catch (e) {
      print(e.toString());
      emit(GetProfileErrorState(e.toString()));
    }
  }

  EditProfileModel? editProfileModel;
  Future<ProfileModel?> editProfileData(Map<String, dynamic> data) async {
    emit(EditProfileLoadingState());
    try {
      final response =
          await DioHelper.updateData(endPoint: 'update-profile', data: data);
      profileModel = ProfileModel.fromJson(response.data);
      print(profileModel!.message);
      // editProfileModel = EditProfileModel.fromJson(response.data);
      // print(profileModel!.message);
      // getProfileData();
      emit(EditProfileSuccuessState(editProfileModel!));
    } catch (e) {
      print(e.toString());
      emit(EditProfileErrorState(e.toString()));
    }
  }

  Future changePassword(Map<String, dynamic> data) async {
    emit(ChangePasswordLoadingState());
    try {
      final response = await DioHelper.postData(
          endPoint: 'change-password', data: data, token: token);

      print(response.data);

      emit(ChangePasswordSuccuessState(response.data));
    } catch (e) {
      print(e.toString());
      emit(ChangePasswordErrorState(e.toString()));
    }
  }

  Future logout() async {
    emit(LogoutLoadingState());
    try {
      final response = await DioHelper.postData(
          endPoint: 'logout', data: {"fcm_token": "SomeFmToken"}, token: token);
      print(response.data);
      emit(LogoutSuccuessState(response.data));
    } catch (e) {
      print(e.toString());
      emit(LogoutErrorState(e.toString()));
    }
  }
}
