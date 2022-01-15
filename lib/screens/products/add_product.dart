import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/models/products_model.dart';
import 'package:hand_made_new/models/user_model.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';
import 'package:conditional_builder/conditional_builder.dart';

class AddProduct extends StatefulWidget {
  static String id = "AddProduct";

  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> meals = [
    'اختار الفئة',
    'حلويات',
    'غداء',
    'عشاء',
    'فطور',
    'بوفيه مفتوح'
  ];
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    setState(() {
      HandCubit.get(context).image = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BlocBuilder<HandCubit, HandMadeState>(
      builder: (context, state) {
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
                key: formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      defaultTextFormField(
                        text: 'product name',
                        controller: _nameController,
                        type: TextInputType.name,
                        function: (value) {
                          if (value.isEmpty) {
                            return 'this field can not be empty';
                          }
                        },
                        sec: false,
                        showPass: null,
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      defaultTextFormField(
                        text: 'description',
                        controller: _descriptionController,
                        type: TextInputType.text,
                        function: (value) {
                          if (value.isEmpty) {
                            return 'this field can not be empty';
                          }
                        },
                        sec: false,
                        showPass: null,
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      defaultTextFormField(
                        text: 'price',
                        controller: _priceController,
                        type: TextInputType.number,
                        function: (value) {
                          if (value.isEmpty) {
                            return 'this field can not be empty';
                          }
                        },
                        sec: false,
                        showPass: null,
                      ),
                      SizedBox(
                        height: _height * 0.06,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        height: _height * 0.20,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: HandCubit.get(context).image == null
                                ? containerBuildTap(
                                    text: 'Select image',
                                    onTap: () {
                                      showDialogBuild(context);
                                    })
                                : Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Image.file(
                                      HandCubit.get(context).image,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ConditionalBuilder(
                            condition: state is! HandUploadImageLoadingState,
                            builder: (context) => containerBuildTap(
                                text: 'Add Product',
                                onTap: () {
                                  if (formKey.currentState.validate() &&
                                      HandCubit.get(context).image != null) {
                                    HandCubit.get(context).addProductWithImage(
                                        name: _nameController.text,
                                        des: _descriptionController.text,
                                        price: _priceController.text);
                                  } else if (formKey.currentState.validate() &&
                                      HandCubit.get(context).image == null) {
                                    showMessageError('Please Add Image ');
                                  }
                                  // HandCubit.get(context).image = null;
                                }),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
