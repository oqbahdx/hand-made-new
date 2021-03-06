import 'package:flutter/material.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import '/components/containers.dart';
import '/screens/account/seller_register.dart';
import '/styles/fonts.dart';
import '/widgets/navigators.dart';

import 'buyer_register.dart';

class RegisterMainPage extends StatelessWidget {
  static String id = "RegisterMainPage";

  const RegisterMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: Text(
            'Register',
            style: appBarStyle,
          ),
          elevation: 0.0,
          action: Container()),
      body: Container(
        height: double.infinity,
        decoration:
             BoxDecoration(
              gradient: LinearGradient(colors: gradientColor)
            ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
             SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: registerCard(context:context ,text: 'Buyer',onTap:(){
                moveToPage(context, BuyerRegisterPage.id);
              } ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: registerCard(context:context ,text: 'Seller',onTap: (){
                moveToPage(context, SellerRegisterPage.id);
              }),
            )
          ],
        ),
      ),
    );
  }
}
