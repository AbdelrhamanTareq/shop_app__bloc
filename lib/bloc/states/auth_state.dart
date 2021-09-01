import 'package:shop_app_bloc/models/login_model.dart';

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
