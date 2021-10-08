import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/state_management/states.dart';


class HandCubit extends Cubit<HandMadeState> {
  HandCubit() : super(HandInitialState());

  static HandCubit get(context) => BlocProvider.of(context);

  int pageIndex = 1;

  changeIndex(int index) {
    pageIndex = index;
    emit(HandChangeButtonNavState());
  }
}
