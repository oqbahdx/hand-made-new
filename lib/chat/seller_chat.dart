import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class SellerChat extends StatefulWidget {
  final String uid;
  final String name;
  final String image;

  const SellerChat({Key key, this.uid, this.name, this.image})
      : super(key: key);
  static String id = "SellerChat";

  @override
  _SellerChatState createState() => _SellerChatState();
}

class _SellerChatState extends State<SellerChat> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 20.0,
          action: Image.network(widget.image)),
      body: Container(
        width: double.infinity,
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Hello From OQBAH',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(15))),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Hello From ME',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(15),
                      )),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        controller: messageController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Type Something Here',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                      iconSize: 35,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
