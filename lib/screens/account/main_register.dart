import 'package:flutter/material.dart';
import 'package:hand_made_new/screens/home/start.dart';
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
        title: Text('Register',style: normalText,),
        elevation: 0.0,
        action: Container()
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150,),
            Container(
              height: 150,
              alignment: Alignment.center,
              child: Text('choose',style: bigText,),
            ),
            Row(
              children: [
                Expanded(
                  child: containerBuildTap(
                      h: 150,
                      onTap: (){
                        moveToPage(context, SellerRegisterPage.id);
                      },
                      text: 'Seller'
                  ),
                ),
                Expanded(child:  containerBuildTap(
                    h: 150,

                    onTap: (){
                      moveToPage(context, BuyerRegisterPage.id);
                    },
                    text: 'Buyer'
                ),)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
