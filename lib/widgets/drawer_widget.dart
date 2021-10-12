import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/products/add_product.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/navigators.dart';


Drawer drawerBuild(BuildContext context){
  return Drawer(

   child:Column(

     children: [
       SizedBox(height: 50,),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
         Stack(children: [
           CircleAvatar(
             backgroundColor: Colors.transparent,
             maxRadius: 50,
             child: Image.asset('assets/personicon.png'),
           ),
           Positioned(
               bottom: 0,
               right: 0,
               child: GestureDetector(
                   onTap: (){

                   },
                   child: Icon(Icons.edit,color: Colors.white,))

           ),
         ],),
         Text('user name',style: normalText,),

       ],),
       Divider(),
       GridView(

         children: [

           containerBuildTap(text: 'Add Product',onTap:(){
             moveToPage(context, AddProduct.id);
           }),
           containerBuildTap(text: 'My Products',onTap: (){}),
           containerBuildTap(text: 'My TimeLine',onTap: (){}),
           containerBuildTap(text: 'Favorite',onTap: (){}),
           containerBuildTap(text: 'Contact Us',onTap: (){}),
         ],
         shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 3/2,
         crossAxisSpacing: 5.0,
       ),

       ),
       SizedBox(height: 240,),
       defaultButtonTap('LOGOUT', (){}),
     ],
   )

  );
}

