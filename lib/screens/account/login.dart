import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/storage/shared.dart';
import '/components/containers.dart';
import '/screens/account/main_register.dart';
import '/screens/account/otp.dart';
import '/screens/home/start.dart';
import '/bloc/cubit.dart';
import '/bloc/states.dart';
import '/styles/fonts.dart';
import '/widgets/app_bar.dart';
import '/widgets/navigators.dart';
import '/widgets/text_from_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static String id = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => HandCubit(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {
          if(state is HandBuyerLoginSuccessState){
            SharedPref.saveData(
                key: 'uId', value: state.uid.toString()).then((value){
              moveToPageAndFinish(context, const StartPage());
            });

          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: appBarWidget(
                title: Text(
                  'Login',
                  style: normalText,
                ),
                elevation: 0.0,
                action: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              ),
              body: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: h * 0.005,
                    ),
                    SizedBox(
                      height: 250,
                      width: 350,
                      child: Image.asset('assets/applogo.png'),
                    ),
                    SizedBox(
                      height: h * 0.035,
                    ),
                    defaultTextFormField(
                        text: 'email',
                        showPass: null,
                        sec: false,
                        function: (value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                        },
                        controller: emailController,
                        icn: Icons.email,
                        type: TextInputType.emailAddress,
                        saveFunction: null),
                    SizedBox(
                      height: h * 0.035,
                    ),
                    defaultTextFormField(
                        text: 'password',
                        showPass: IconButton(
                            onPressed: () {
                              HandCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(HandCubit.get(context).icon)),
                        sec: HandCubit.get(context).isShow,
                        function: (value) {
                          if (value.isEmpty) {
                            return 'password is empty';
                          }
                        },
                        controller: passwordController,
                        icn: Icons.enhanced_encryption,
                        type: TextInputType.text),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Forget password  ?',
                            style: smallText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: gradientText(
                              text: 'Click Here',
                              onTap: () {
                                moveToPage(context, OTPPage.id);
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: h * 0.015,
                    ),
                    ConditionalBuilder(
                      condition: state is! HandBuyerLoginLoadingState,
                      builder: (context) => containerBuildTap(
                          h: h * 0.075,
                          text: 'Login',
                          onTap: () async {
                            if (formKey.currentState.validate()) {
                              HandCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }


                          }),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: h * 0.025,
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
                              text: 'REG',
                              onTap: () {
                                moveToPageAndFinish(
                                    context, const RegisterMainPage());
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
