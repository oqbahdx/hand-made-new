import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import '/bloc/cubit.dart';
import '/bloc/states.dart';
import '/widgets/text_from_field.dart';
import 'login.dart';

class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key key}) : super(key: key);
  static String id = "BuyerRegisterPage";

  @override
  _BuyerRegisterPageState createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HandCubit(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {
          if(state is HandSellerRegisterSuccessState)
            {
             moveToPageAndFinish(context, LoginPage());
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appBarWidget(
                action: Container(),
                elevation: 0.0,
                title: Text(
                  'Buyer Register',
                  style: normalText,
                )),
            body: SingleChildScrollView(
              child: Form(
                key: HandCubit.get(context).formKey,
                child: Column(
                  children: [
                     SizedBox(
                      height: h * 0.05,
                    ),
                    defaultTextFormField(
                        text: 'Name',
                        type: TextInputType.name,
                        icn: Icons.person,
                        controller: nameController,
                        saveFunction: (value) {
                          value = nameController.text;
                        },
                        function: (data) {
                          if (data.isEmpty) {
                            return 'please enter your name';
                          }
                        }),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    defaultTextFormField(
                        text: 'Email',
                        type: TextInputType.emailAddress,
                        icn: Icons.email,
                        controller: emailController,
                        saveFunction: (value) {
                          value = emailController.text;
                        },
                        function: (data) {
                          if (data.isEmpty) {
                            return 'please enter your email';
                          }
                        }),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    defaultTextFormField(
                        text: 'Password',
                        type: TextInputType.text,
                        icn: Icons.enhanced_encryption,
                        controller: passwordController,
                        saveFunction: (value) {
                          value = passwordController.text;
                        },
                        sec: HandCubit.get(context).isShow,
                        showPass: IconButton(
                            onPressed: () {
                              HandCubit.get(context).changePasswordVisibility();
                            },
                            icon: Icon(HandCubit.get(context).icon)),
                        function: (data) {
                          if (data.isEmpty) {
                            return 'please enter your password';
                          }
                        }),
                    SizedBox(
                      height: h * 0.20,
                    ),
                    ConditionalBuilder(
                      condition: state is! HandGetUserLoadingState,
                      builder: (context) => containerBuildTap(
                         h: h * 0.075,
                          text: 'REGISTER',onTap:  () {
                        HandCubit.get(context).userBuyerRegister(
                          name: nameController.text,
                          email: emailController.text,
                          password:passwordController.text,
                        );
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
            ),
          );
        },
      ),
    );
  }
}
