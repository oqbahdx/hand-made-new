import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HandCubit extends Cubit<HandMadeState> {
  HandCubit() : super(HandInitialState());

  static HandCubit get(context) => BlocProvider.of(context);

  int pageIndex = 1;

  changeIndex(int index) {
    pageIndex = index;
    emit(HandChangeButtonNavState());
  }

  String dropdownValueTime = 'اختار اليوم';
  String dropdownValueCategory = 'اختار الفئة';
  String productCategory;

  changeDropItem(String newValue,String value){
    dropdownValueCategory = newValue;
    productCategory = value;
    emit(HandChangeDropMenuItemState());
  }

  final picker = ImagePicker();
  File image = null;
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(
        source: src, imageQuality: 50, maxHeight: 300, maxWidth: 300);

      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
      print(image.path.split('/').last);
      emit(HandShowDialogState());
  }

}
