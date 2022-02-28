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

class HandAddProductLoadingState extends HandMadeState {}

class HandAddProductSuccessState extends HandMadeState {}

class HandAddProductErrorState extends HandMadeState {
  final String error;

  HandAddProductErrorState(this.error);
}

class HandUploadImageLoadingState extends HandMadeState {}

class HandUploadImageSuccessState extends HandMadeState {}

class HandUploadImageErrorState extends HandMadeState {
  final String error;

  HandUploadImageErrorState(this.error);
}

class HandGetCurrentUserProductsLoadingState extends HandMadeState {}

class HandGetCurrentUserProductsSuccessState extends HandMadeState {}

class HandGetCurrentUserProductsErrorState extends HandMadeState {
  final String error;

  HandGetCurrentUserProductsErrorState(this.error);
}
class HandGetMyProductsLoading extends HandMadeState{}
class HandGetMyProductsSuccess extends HandMadeState{}
class HandGetMyProductsError extends HandMadeState{
  final String error;

  HandGetMyProductsError(this.error);
}

class HandUpdateCurrentUserProfileLoading extends HandMadeState{}
class HandUpdateCurrentUserProfileSuccess extends HandMadeState{}
class HandUpdateCurrentUserProfileError extends HandMadeState{
  final String error;

  HandUpdateCurrentUserProfileError(this.error);
}

class HandChangeIsOnlineState extends HandMadeState{}

class HandUpdateProfileWithImageLoading extends HandMadeState{}
class HandUpdateProfileWithImageSuccess extends HandMadeState{}
class HandUpdateProfileWithImageError extends HandMadeState{
  final String error;

  HandUpdateProfileWithImageError(this.error);
}

class HandSendMessageLoading extends HandMadeState {}
class HandSendMessageSuccess extends HandMadeState {}
class HandSendMessageError extends HandMadeState {
  final String error ;

  HandSendMessageError(this.error);
}

class HandGetMessagesSuccess extends HandMadeState {}
class HandGetMessagesLoading extends HandMadeState {}
class HandAddToFavoriteLoading extends HandMadeState {}
class HandAddToFavoriteSuccess extends HandMadeState {}
class HandAddToFavoriteError extends HandMadeState {
  final String error;

  HandAddToFavoriteError(this.error);
}