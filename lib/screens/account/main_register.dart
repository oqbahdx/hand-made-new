import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/account/buyer_register.dart';
import 'package:hand_made_new/screens/account/login.dart';
import 'package:hand_made_new/screens/account/seller_register.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';


class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({Key key}) : super(key: key);
  static String id = "RegisterMainPage";
  @override
  _RegisterMainPageState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  List<String> titles = [
    'Buyer Register',
    'Seller Register'
  ];
  @override
  Widget build(BuildContext context) {
   double h = MediaQuery.of(context).size.height;
   double w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create:(BuildContext context)=>HandCubit(),
      child: BlocConsumer<HandCubit,HandMadeState>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: appBarWidget(
              action: IconButton(onPressed: (){

              }, icon: Icon(Icons.close)),
              elevation: 0.0,
              title: Text(titles[ HandCubit.get(context).index],style: normalText,),

            ),
            body: SingleChildScrollView(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    height: h*.70,
                    child: PageView(
                      onPageChanged:(int value){
                        HandCubit.get(context).pageChanged(value);
                      },
                      physics: BouncingScrollPhysics(),
                      children: [
                        BuyerRegisterPage(),
                        SellerRegisterPage(),

                      ],),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: h*.18,
                    child: Column(children: [
                      containerBuildTap(text: 'Register',onTap: (){
                        HandCubit.get(context).formKey.currentState.validate();
                      }),
                      SizedBox(height: h*.035,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Text('You have already account ? ',style: normalText,),
                        gradientText(text: 'LOGIN',onTap: (){
                          moveToPageAndFinish(context,LoginPage());
                        })
                      ],)
                    ],),
                  ),
                ],
              ),
            )

          );
        },
      ),
    );
  }
}
