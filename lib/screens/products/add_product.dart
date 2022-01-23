import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/screens/products/my_products.dart';
import 'package:hand_made_new/styles/colors.dart';

import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
import 'package:hand_made_new/widgets/text_form_background.dart';
import 'package:conditional_builder/conditional_builder.dart';

class AddProduct extends StatefulWidget {
  static String id = "AddProduct";

  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {
        if (state is HandAddProductSuccessState) {
          showMessageSuccess('Product Add Successfully');
          moveToPage(context, MyProducts.id);
        } else if (state is HandAddProductErrorState) {
          showMessageError('Field Add Product');
        } else {}
      },
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
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    buildTextFormFieldWithBackground(
                      inputType: TextInputType.text,
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Product Name';
                          }
                        },
                        txt: 'Name Of The Product'),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    buildTextFormFieldWithBackground(
                        inputType: TextInputType.text,
                        controller: _descriptionController,
                        txt: 'Description',
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter The Description";
                          }
                        }),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    buildTextFormFieldWithBackground(
                        inputType: TextInputType.number,
                        controller: _priceController,
                        txt: 'Price',
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter The Price";
                          }
                        }),
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
                              ? buildTapBlack(
                                  text: 'Select image',
                                  onTap: () {
                                    showDialogBuild(context);
                                  })
                              : SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.file(
                                    HandCubit.get(context).image,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                    ),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ConditionalBuilder(
                          condition: state is! HandUploadImageLoadingState,
                          builder: (context) => buildTapBlack(
                              h: _height * 0.08,
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
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
