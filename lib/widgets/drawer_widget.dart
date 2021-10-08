import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containters.dart';
import 'package:hand_made_new/styles/colors.dart';


Drawer drawerBuild(){
  return Drawer(

   child:Column(

     children: [
       SizedBox(height: 100,),
       Divider(),
       GridView(

         children: [

           containerBuildTap(text: 'Add Product',onTap:(){}),
           containerBuildTap(text: 'Favorite',onTap: (){}),
           containerBuildTap(text: 'Contact Us',onTap: (){}),
         ],
         shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 3/2,
         crossAxisSpacing: 5.0,
       ),

       )
     ],
   )

  );
}

