import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/styles/colors.dart';

import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/callback.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
import 'package:hand_made_new/widgets/text_form_background.dart';
import 'package:conditional_builder/conditional_builder.dart';

class EditProduct extends StatefulWidget {
  static String id = "EditProduct";
  final String uid;
  final String name;
  final String image;
  final String price;
  final String desc;

  const EditProduct(
      {Key key, this.uid, this.name, this.image, this.price, this.desc})
      : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    setState(() {
      HandCubit.get(context).image = null;
      _nameController.text = widget.name;
      _descriptionController.text = widget.desc;
      _priceController.text = widget.price;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {
        if (state is HandUpdateProductSuccess) {
          showMessageSuccess('Product Has Been Edit Successfully');
          moveToPageAndFinish(context, const StartPage());
        } else if (state is HandUpdateProductError) {
          showMessageError('Field To Edit Product');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: appBarWidget(
                title: Text(
                  'Edit Product',
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
                        txt: "product name"),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    buildTextFormFieldWithBackground(
                        inputType: TextInputType.text,
                        controller: _descriptionController,
                        txt: "product description",
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
                        txt: "product price",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter The Price";
                          }
                        }),
                    SizedBox(
                      height: _height * 0.06,
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Hero(
                            tag: widget.uid,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              height: _height * 0.20,
                              child: HandCubit.get(context).image == null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.image,
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: double.infinity,
                                      placeholder: (context, url) =>
                                          Image.asset('assets/pleaceholder.png',
                                              color: Colors.black87),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.file(
                                      HandCubit.get(context).image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 20,
                            child: IconButton(
                              onPressed: () {
                                showDialogBuild(context);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ConditionalBuilder(
                            condition: state is! HandUpdateProductLoading,
                            builder: (context) => BuildTapBlack(
                                h: _height * 0.08,
                                text: 'Update Product',
                                onTap: () {
                                  if (formKey.currentState.validate()) {
                                    HandCubit.get(context).image == null
                                        ? HandCubit.get(context).updateProduct(
                                            uid: FirebaseAuth
                                                .instance.currentUser.uid,
                                            id: widget.uid,
                                            name: _nameController.text,
                                            price: _priceController.text,
                                            desc: _descriptionController.text,
                                            image: widget.image)
                                        : HandCubit.get(context)
                                            .updateProductWithImage(
                                                uid: FirebaseAuth
                                                    .instance.currentUser.uid,
                                                id: widget.uid,
                                                name: _nameController.text,
                                                price: _priceController.text,
                                                des: _descriptionController
                                                    .text);
                                  }
                                }),
                            fallback: (context) => const CallBackIndicator())),
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
