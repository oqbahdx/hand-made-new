import 'dart:async';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/home/start.dart';
import '/components/containers.dart';
import '/bloc/states.dart';
import '/widgets/navigators.dart';
import 'package:permission_handler/permission_handler.dart';
import '/bloc/cubit.dart';
import '/styles/fonts.dart';
import '/widgets/app_bar.dart';
import '/widgets/text_from_field.dart';
import 'login.dart';

class SellerRegisterPage extends StatefulWidget {
  const SellerRegisterPage({Key key}) : super(key: key);
  static String id = "SellerRegisterPage";

  @override
  _SellerRegisterPageState createState() => _SellerRegisterPageState();
}

class _SellerRegisterPageState extends State<SellerRegisterPage> {
  Permission permission;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {
        if (state is HandSellerRegisterSuccessState) {
          moveToPageAndFinish(context, LoginPage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: appBarWidget(
              action: Container(),
              elevation: 0.0,
              title: Text(
                'Seller Register',
                style: normalText,
              )),
          body: Form(
            key: formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: h * 0.05,
                ),
                defaultTextFormField(
                    text: 'Name',
                    type: TextInputType.name,
                    icn: Icons.person,
                    controller: nameController,
                    function: (value) {
                      if (value.isEmpty) return 'please enter your name';
                    }),
                SizedBox(
                  height: h * 0.05,
                ),
                defaultTextFormField(
                    text: 'Email',
                    type: TextInputType.emailAddress,
                    icn: Icons.email,
                    controller: emailController,
                    function: (value) {
                      if (value.isEmpty) return 'please enter your email';
                    }),
                SizedBox(
                  height: h * 0.05,
                ),
                defaultTextFormField(
                    text: 'Phone',
                    type: TextInputType.number,
                    icn: Icons.phone,
                    controller: phoneController,
                    function: (value) {
                      if (value.isEmpty) return 'please enter your phone';
                    }),
                SizedBox(
                  height: h * 0.05,
                ),
                defaultTextFormField(
                  text: 'Password',
                  type: TextInputType.text,
                  icn: Icons.enhanced_encryption,
                  controller: passwordController,
                  function: (value) {
                    if (value.isEmpty) return 'please enter your password';
                  },
                  sec: HandCubit.get(context).isShow,
                  showPass: IconButton(
                      onPressed: () {
                        HandCubit.get(context).changePasswordVisibility();
                      },
                      icon: Icon(HandCubit.get(context).icon)),
                ),
                SizedBox(
                  height: h * 0.055,
                ),
                ConditionalBuilder(
                  condition: state is! HandGetUserLoadingState,
                  builder: (context) => containerBuildTap(
                      h: h * 0.075,
                      text: 'REGISTER',
                      onTap: () async {
                        var status = await Permission.location.status;
                        if (status.isDenied) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Please give app location permission to register as seller")));
                         Timer(Duration(seconds: 3),(){
                           openAppSettings();
                         });
                        } else {
                          HandCubit.get(context).userSellerRegister(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                          );
                          moveToPageAndFinish(context, StartPage());
                        }
                      }),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(
                  height: h * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'You have already account ? ',
                        style: normalText,
                      ),
                      gradientText(
                          text: 'LOG',
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginPage.id, (route) => false);
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
