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

class HandBuyerRegisterSuccessState extends HandMadeState {}

class HandBuyerRegisterLoadingState extends HandMadeState {}

class HandBuyerRegisterErrorState extends HandMadeState {
  final String error;

  HandBuyerRegisterErrorState(this.error);
}

class HandBuyerLoginSuccessState extends HandMadeState {
  final String uid;

  HandBuyerLoginSuccessState(this.uid);
}

class HandBuyerLoginLoadingState extends HandMadeState {}

class HandBuyerLoginErrorState extends HandMadeState {
  final String error;

  HandBuyerLoginErrorState(this.error);
}

class HandGetSellersSuccessState extends HandMadeState {}

class HandGetSellersLoadingState extends HandMadeState {}

class HandGetSellersErrorState extends HandMadeState {
  final String error;

  HandGetSellersErrorState(this.error);
}

class HandGetUserLoadingState extends HandMadeState {}

class HandGetUserSuccessState extends HandMadeState {}

class HandGetUserErrorState extends HandMadeState {
  final String error;

  HandGetUserErrorState(this.error);
}

class HandUserRegisterLoadingState extends HandMadeState {}

class HandUserRegisterSuccessState extends HandMadeState {}

class HandUserRegisterErrorState extends HandMadeState {
  final String error;

  HandUserRegisterErrorState(this.error);
}

class HandGetCurrentUserLoadingState extends HandMadeState {}

class HandGetCurrentUserSuccessState extends HandMadeState {}

class HandGetCurrentUserErrorState extends HandMadeState {
  final String error;

  HandGetCurrentUserErrorState(this.error);
}
