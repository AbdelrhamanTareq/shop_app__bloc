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
