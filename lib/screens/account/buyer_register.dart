import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/state_management/cubit.dart';
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 90,),
          defaultTextFormField(
            text: 'Name',
            type: TextInputType.name,
            icn: Icons.person,
            controller: null,
          ),
          SizedBox(height: 40,),
          defaultTextFormField(
            text: 'Email',
            type: TextInputType.emailAddress,
            icn: Icons.email,
            controller: null,
          ),
          SizedBox(height: 40,),
          defaultTextFormField(
            text: 'Phone',
            type: TextInputType.number,
            icn: Icons.phone,
            controller: null,
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
          ),

         // containerBuildTap(text: 'Register',onTap: (){}),
        ],
      ),
    );
  }
}
