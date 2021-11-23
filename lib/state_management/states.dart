abstract class HandMadeState {}

class HandInitialState extends HandMadeState {}

class HandLoadingState extends HandMadeState {}

class HandSuccessState extends HandMadeState {}

class HandErrorState extends HandMadeState {
  final String error;

  HandErrorState(this.error);
}

class HandChangeButtonNavState extends HandMadeState {}

class HandChangeDropMenuItemState extends HandMadeState {}

class HandShowDialogState extends HandMadeState {}

class HandChangePasswordVisibility extends HandMadeState {}

class HandUpdateImageSuccessState extends HandMadeState {}

class HandChangeTitleMainRegisterSuccessState extends HandMadeState {}

class HandSellerRegisterLoadingState extends HandMadeState {}

class HandSellerRegisterSuccessState extends HandMadeState {}

class HandSellerRegisterErrorState extends HandMadeState {
  final String error;

  HandSellerRegisterErrorState(this.error);
}
