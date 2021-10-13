import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';

class AddProduct extends StatefulWidget {
  static String id = "AddProduct";

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: appBarWidget(
              title: Text(
                'Add Product',
                style: normalText,
              ),
              action: Container(),
              elevation: 0.0),
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  defaultTextFormField(
                    text: 'name',
                    controller: null,
                    type: TextInputType.name,
                    icn: Icons.person,
                    function: (a) {},
                    sec: false,
                    showPass: null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    text: 'description',
                    controller: null,
                    type: TextInputType.text,
                    icn: Icons.person,
                    function: (a) {},
                    sec: false,
                    showPass: null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    text: 'price',
                    controller: null,
                    type: TextInputType.number,
                    icn: Icons.person,
                    function: (a) {},
                    sec: false,
                    showPass: null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    text: 'calories',
                    controller: null,
                    type: TextInputType.number,
                    icn: Icons.person,
                    function: (a) {},
                    sec: false,
                    showPass: null,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
