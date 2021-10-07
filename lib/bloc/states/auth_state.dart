import 'package:shop_app_bloc/models/profile_model.dart';

import '/models/login_model.dart';

abstract class AppAuthState {}

class AppAuthInitialState extends AppAuthState {}

class AppLoginLoadingState extends AppAuthState {}

class AppLoginSuccuessState extends AppAuthState {
  final LoginModel loginModel;
  AppLoginSuccuessState(this.loginModel);
}

class AppLoginErrorState extends AppAuthState {
  final String error;

  AppLoginErrorState(this.error);
}

class AppLoginChangeSuffixIconState extends AppAuthState {}

class AppRegisterLoadingState extends AppAuthState {}

class AppRegisterSuccuessState extends AppAuthState {
  final LoginModel loginModel;
  AppRegisterSuccuessState(this.loginModel);
}

class AppRegisterErrorState extends AppAuthState {
  final String error;

  AppRegisterErrorState(this.error);
}

class GetProfileLoadingState extends AppAuthState {}

class GetProfileSuccuessState extends AppAuthState {
  final ProfileModel profielModel;
  GetProfileSuccuessState(this.profielModel);
}

class GetProfileErrorState extends AppAuthState {
  final String error;

  GetProfileErrorState(this.error);
}

class EditProfileLoadingState extends AppAuthState {}

class EditProfileSuccuessState extends AppAuthState {
  final EditProfileModel editProfielModel;
  EditProfileSuccuessState(this.editProfielModel);
}

class EditProfileErrorState extends AppAuthState {
  final String error;

  EditProfileErrorState(this.error);
}

class ChangePasswordLoadingState extends AppAuthState {}

class ChangePasswordSuccuessState extends AppAuthState {
  final Map<String, dynamic> data;
  ChangePasswordSuccuessState(this.data);
}

class ChangePasswordErrorState extends AppAuthState {
  final String error;

  ChangePasswordErrorState(this.error);
}
