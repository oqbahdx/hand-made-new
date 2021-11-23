import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/components/drop_menu.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';

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
  

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BlocProvider(create: (BuildContext context)=>HandCubit(),
    child: BlocConsumer<HandCubit,HandMadeState>(
      listener: (context,state){},
      builder: (context,state){
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
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      height: _height * 0.15,
                      width: _width * 0.95,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: HandCubit.get(context).image == null
                              ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: const Center(
                              child: Text(
                                "الرجاء إضافه صورة",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'messiri'),
                              ),
                            ),
                          )
                              : Image.file(
                            HandCubit.get(context).image,
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
                              showDialogBuild(context);
                            }
                        )),

                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text('Don\' have an account ? ',style: normalText,),
                      gradientText(text: 'Register Now',onTap: (){
                        print('you clicked here');
                      })
                    ],),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
