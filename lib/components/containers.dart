import 'package:flutter/material.dart';
import 'package:hand_made_new/models/products_model.dart';

import 'package:hand_made_new/models/user_model.dart';
import '/styles/colors.dart';
import '/styles/fonts.dart';

Widget containerBuildTap(
    {String text, Function onTap, double h = 50, double w = 600}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: containerStyle,
          ),
        ),
        height: h,
        width: w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            )),
      ),
    ),
  );
}

Widget defaultButtonTap(String text, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            text,
            style: containerStyle,
          ),
        ),
      ),
    ),
  );
}

Widget familiesContainer({UserModel model, Function onTap}) {
  return Center(
    child: ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: onTap,
            child: Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black38),
                child: Text(
                  model.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget PositionedBuild({double h, double w, String txt}) {
  return Container(
    height: h,
    width: w,
    child: Card(
      elevation: 0.0,
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
          topLeft: Radius.circular(100),
        ),

      ),

      child: Center(
          child: Text(
            txt,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          )),
    ),
  );


}

Widget buildProductsItem(ProductsModel model){
  return Container(
    alignment: Alignment.center,
    child: Column(
      children: [
        Container(
          child: FadeInImage(
            width: double.infinity,
            fit: BoxFit.fill,
            image: NetworkImage('${model.image}'),
            placeholder: AssetImage('assets/pleaceholder.png'),
          ),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10,),
        Text('${model.name}',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),)
      ],
    ),
    height: 250,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey,
    ),
  );
}