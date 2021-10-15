import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/components/drop_menu.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
class AddProduct extends StatefulWidget {
  static String id = "AddProduct";

  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List <String> meals = [
  'اختار الفئة',
  'حلويات',
  'غداء',
  'عشاء',
  'فطور',
  'بوفيه مفتوح'
  ];
  final picker = ImagePicker();
  File _image;
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(
        source: src, imageQuality: 50, maxHeight: 300, maxWidth: 300);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
            title: Text(
              'Add Product',
              style: normalText,
            ),
            action: Container(),
            elevation: 0.0),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                defaultTextFormField(
                  text: 'name',
                  controller: null,
                  type: TextInputType.name,
                  icn: Icons.person,
                  function: (a) {},
                  sec: false,
                  showPass: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  text: 'description',
                  controller: null,
                  type: TextInputType.text,
                  icn: Icons.add_comment_sharp,
                  function: (a) {},
                  sec: false,
                  showPass: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  text: 'price',
                  controller: null,
                  type: TextInputType.number,
                  icn: Icons.monetization_on,
                  function: (a) {},
                  sec: false,
                  showPass: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  text: 'calories',
                  controller: null,
                  type: TextInputType.number,
                   icn: Icons.local_fire_department,
                  function: (a) {},
                  sec: false,
                  showPass: null,
                ),
                const SizedBox(
                  height: 20,
                ),

                dropMenuBuild(
                  meals: meals,
                  dropValue: HandCubit.get(context).dropdownValueCategory,
                  fun: HandCubit.get(context).changeDropItem(
                      HandCubit.get(context).dropdownValueCategory,
                      HandCubit.get(context).productCategory,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  height: _height * 0.15,
                  width: _width * 0.95,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: _image == null
                          ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)),
                        child: Center(
                          child: Text(
                            "الرجاء إضافه صورة",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'messiri'),
                          ),
                        ),
                      )
                          : Image.file(
                        _image,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: _height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: containerBuildTap(
                    text: 'Select image',
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: Text(
                            'إختار صورة من :',
                            style: TextStyle(
                              fontFamily: 'messiri',
                            ),
                          ),
                          content: Container(
                            height: 150,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF3E71),
                                          Color(0xFFFEC317),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      'المعرض',
                                      style: TextStyle(
                                          fontFamily: 'messiri',
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      getImage(ImageSource.gallery);

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF3E71),
                                          Color(0xFFFEC317),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    title: Text('الكاميرا',
                                        style: TextStyle(
                                            fontFamily: 'messiri',
                                            color: Colors.white)),
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )));

                    }
                  ))],
            ),
          ),
        ),
      ),
    );
  }
}
