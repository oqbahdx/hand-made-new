import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/state_management/states.dart';

import '/state_management/cubit.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
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
                  height: 90,
                ),
                defaultTextFormField(
                  text: 'Name',
                  type: TextInputType.name,
                  icn: Icons.person,
                  controller: nameController,
                  function: (value){
                    if(value.isEmpty) return 'please enter your name';
                  }
                ),
                SizedBox(
                  height: 40,
                ),
                defaultTextFormField(
                  text: 'Email',
                  type: TextInputType.emailAddress,
                  icn: Icons.email,
                  controller: emailController,
                    function: (value){
                      if(value.isEmpty) return 'please enter your email';
                    }
                ),
                SizedBox(
                  height: 40,
                ),
                defaultTextFormField(
                  text: 'Phone',
                  type: TextInputType.number,
                  icn: Icons.phone,
                  controller: phoneController,
                    function: (value){
                      if(value.isEmpty) return 'please enter your phone';
                    }
                ),
                const SizedBox(
                  height: 40,
                ),
                defaultTextFormField(
                  text: 'Password',
                  type: TextInputType.text,
                  icn: Icons.enhanced_encryption,
                  controller: passwordController,
                    function: (value){
                      if(value.isEmpty) return 'please enter your password';
                    },
                  sec: HandCubit.get(context).isShow,
                  showPass: IconButton(
                      onPressed: () {
                        HandCubit.get(context).changePasswordVisibility();
                      },
                      icon: Icon(HandCubit.get(context).icon)),
                ),
                const SizedBox(
                  height: 80,
                ),
                ConditionalBuilder(
                  condition: state is! HandSellerRegisterLoadingState,
                  builder: (context) => defaultButtonTap('REGISTER', () {
                    HandCubit.get(context).sellerRegister(
                      name: nameController.text,
                      email: emailController.text,
                      password: emailController.text,
                      phone: phoneController.text,
                      isAvailable: 'true',

                    );
                  }),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(
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
        );
      },
    );
  }
}
