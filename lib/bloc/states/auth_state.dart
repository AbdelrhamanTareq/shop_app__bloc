abstract class AppAuthState {}

class AppAuthInitialState extends AppAuthState {}

class AppLoginLoadingState extends AppAuthState {}

class AppLoginSuccuessState extends AppAuthState {}

class AppLoginErrorState extends AppAuthState {
  final String? error;

  AppLoginErrorState(this.error);
}

class AppLoginChangeSuffixIconState extends AppAuthState {}

class AppRegisterLoadingState extends AppAuthState {}

class AppRegisterSuccuessState extends AppAuthState {}

class AppRegisterErrorState extends AppAuthState {
  final String? error;

  AppRegisterErrorState(this.error);
}
