import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/account/verify_otp.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import '/state_management/cubit.dart';
import '/state_management/states.dart';
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
                    const SizedBox(
                      height: 90,
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
                    const SizedBox(
                      height: 40,
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
                    const SizedBox(
                      height: 40,
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
                      height: 180,
                    ),
                    ConditionalBuilder(
                      condition: state is! HandBuyerRegisterLoadingState,
                      builder: (context) => defaultButtonTap('REGISTER', () {
                        HandCubit.get(context).registerBuyer(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                      }),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'You have already account ? ',
                          style: normalText,
                        ),
                        gradientText(
                            text: 'LOGIN',
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LoginPage.id, (route) => false);
                            })
                      ],
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
