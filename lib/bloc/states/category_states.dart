abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}

class CategoryLoadingState extends CategoryStates {}

class CategorySucsessState extends CategoryStates {}

class CategoryErorrState extends CategoryStates {
  final String error;
  CategoryErorrState(this.error);
}

class CategoryDetailsLoadingState extends CategoryStates {}

class CategoryDetailsSucsessState extends CategoryStates {}

class CategoryDetailsErorrState extends CategoryStates {
  final String error;
  CategoryDetailsErorrState(this.error);
}
