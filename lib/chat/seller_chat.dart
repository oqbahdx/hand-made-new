import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';


class SellerChat extends StatefulWidget {
  final String uid;
  final String name;
  final String image;
  const SellerChat({Key key, this.uid, this.name, this.image}) : super(key: key);
   static String id = "SellerChat";
  @override
  _SellerChatState createState() => _SellerChatState();
}

class _SellerChatState extends State<SellerChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBarWidget(
         title: Text(widget.name,style: const TextStyle(
           fontWeight: FontWeight.bold
         ),),
         elevation: 20.0,
         action: Image.network(widget.image)
       ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor
          )
        ),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(

                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(15),
                    )
                  ),
                ),
              ),
              SizedBox(height: 150,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'enter your message here ...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
