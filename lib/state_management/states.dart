abstract class HandMadeState {}

class HandInitialState extends HandMadeState{}
class HandLoadingState extends HandMadeState{}
class HandSuccessState extends HandMadeState{}
class HandErrorState extends HandMadeState{
   final String error;
  HandErrorState(this.error);
}

class HandChangeButtonNavState extends HandMadeState {}
class HandChangeDropMenuItemState extends HandMadeState {}
class HandShowDialogState extends HandMadeState {}