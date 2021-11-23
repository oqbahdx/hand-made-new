import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';

class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key key}) : super(key: key);
  static String id = "BuyerRegisterPage";

  @override
  _BuyerRegisterPageState createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HandCubit(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                        controller: HandCubit.get(context).nameController,
                        saveFunction: (value){
                          value = HandCubit.get(context).nameController.text;
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
                        controller: HandCubit.get(context).emailController,
                        saveFunction: (value){
                          value = HandCubit.get(context).emailController.text;
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
                        text: 'Phone',
                        type: TextInputType.number,
                        icn: Icons.phone,
                        controller: HandCubit.get(context).phoneController,
                        saveFunction: (value){
                          value = HandCubit.get(context).phoneController.text;
                        },
                        function: (data) {
                          if (data.isEmpty) {
                            return 'please enter your phone';
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultTextFormField(
                        text: 'Password',
                        type: TextInputType.text,
                        icn: Icons.enhanced_encryption,
                        controller: HandCubit.get(context).passwordController,
                        saveFunction: (value){
                          value = HandCubit.get(context).passwordController.text;
                        },
                        sec: HandCubit.get(context).isShow,
                        showPass: IconButton(
                            onPressed: () {
                              HandCubit.get(context).changePasswordVisibility();
                            },
                            icon: Icon(HandCubit.get(context).icon)),
                        function: (data) {
                          if (data.isEmpty){
                            return 'please enter your password';
                          }
                        }),

                    // containerBuildTap(text: 'Register',onTap: (){}),
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
