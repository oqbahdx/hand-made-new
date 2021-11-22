import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/styles/fonts.dart';
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
    var cubit = HandCubit.get(context);
    return BlocConsumer<HandCubit,HandMadeState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  defaultTextFormField(
                    text: 'Name',
                    type: TextInputType.name,
                    icn: Icons.person,
                    controller: null,
                    function: (data){
                      if(data.isEmpty) return 'please enter your name';
                    }
                  ),
                  SizedBox(height: 40,),
                  defaultTextFormField(
                    text: 'Email',
                    type: TextInputType.emailAddress,
                    icn: Icons.email,
                    controller: null,
                      function: (data){
                        if(data.isEmpty) return 'please enter your email';
                      }
                  ),
                  SizedBox(height: 40,),
                  defaultTextFormField(
                    text: 'Phone',
                    type: TextInputType.number,
                    icn: Icons.phone,
                    controller: null,
                      function: (data){
                        if(data.isEmpty) return 'please enter your phone';
                      }
                  ),
                  SizedBox(height: 40,),
                  defaultTextFormField(
                    text: 'Password',
                    type: TextInputType.text,
                    icn: Icons.enhanced_encryption,
                    controller: null,
                    sec: HandCubit.get(context).isShow,
                    showPass: IconButton(onPressed: (){
                      HandCubit.get(context).changePasswordVisibility();
                    }, icon: Icon(HandCubit.get(context).icon)),
                      function: (data){
                        if(data.isEmpty) return 'please enter your password';
                      }
                  ),

                  // containerBuildTap(text: 'Register',onTap: (){}),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
