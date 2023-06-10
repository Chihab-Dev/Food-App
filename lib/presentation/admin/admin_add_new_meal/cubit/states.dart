abstract class AddNewMealStates {}

class AddNewMealInitState extends AddNewMealStates {}

// pick image

class PickImageLoadingState extends AddNewMealStates {}

class PickImageSuccessState extends AddNewMealStates {}

class PickImageErrorState extends AddNewMealStates {
  final String error;

  PickImageErrorState(this.error);
}

// Price value

class AddNewMealChangePriceValueState extends AddNewMealStates {}
// Stars value

class AddNewMealChangeStarsValueState extends AddNewMealStates {}

// ADD item to database

class AddNewMealLoadingState extends AddNewMealStates {}

class AddNewMealSuccessState extends AddNewMealStates {}

class AddNewMealErrorState extends AddNewMealStates {
  final String error;

  AddNewMealErrorState(this.error);
}

// Name check

class AddNewMealIsNameValidState extends AddNewMealStates {}

class AddNewMealNameErrorState extends AddNewMealStates {}

// Desc check

class AddNewMealIsDescValidState extends AddNewMealStates {}

class AddNewMealDescErrorState extends AddNewMealStates {}

// is All parameters Valid

class AddNewMealIsAllParemetersValidState extends AddNewMealStates {}
