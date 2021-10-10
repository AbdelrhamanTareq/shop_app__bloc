abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccsesState extends HomeStates {}

class HomeErorrState extends HomeStates {
  final String error;
  HomeErorrState(this.error);
}

class HomeChangeNavBarState extends HomeStates {}

class HomeAddOrRemoveFavoreitesChangeState extends HomeStates {}

class HomeAddOrRemoveFavoreitesSuccsesState extends HomeStates {}

class HomeAddOrRemoveFavoreitesErrorState extends HomeStates {}

class GetProductDetailsLoadingState extends HomeStates {}

class GetProductDetailSuccsesState extends HomeStates {}

class GetProductDetailsErrorState extends HomeStates {}

class GetCategoryLoadingState extends HomeStates {}

class GetCategorySuccsesState extends HomeStates {}

class GetCategoryErorrState extends HomeStates {}

class GetCategoryDetailsLoadingState extends HomeStates {}

class GetCategoryDetailsSuccsesState extends HomeStates {}

class GetCategoryDetailsErrorState extends HomeStates {}

class GetFavoriteLoadingState extends HomeStates {}

class GetFavoriteSuccsesState extends HomeStates {}

class GetFavoriteErrorState extends HomeStates {
  final String error;
  GetFavoriteErrorState(this.error);
}

class DeleteFavoriteLoadingState extends HomeStates {}

class DeleteFavoriteSuccsesState extends HomeStates {}

class DeleteFavoriteErrorState extends HomeStates {
  final String error;
  DeleteFavoriteErrorState(this.error);
}

class SwitchDarkMode extends HomeStates {}
// class CategoryLoadingState extends HomeStates {}

// class CategorySucsessState extends HomeStates {}

// class CategoryErorrState extends HomeStates {}
