import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/styles/colors.dart';

import '../../components/navigator.dart';
import '../account/sellers_details.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key key}) : super(key: key);
  static String id = "ChatList";

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('messages')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    return ListView(
                      children: snapshot.data.docs.map((document) {
                        final dynamic data = document.data();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              moveToPageWithData(context,
                                  namePage: SellerDetails(
                                    uId: data['uid'].toString(),
                                    name: data['name'].toString(),
                                    image: data['profileImage'].toString(),
                                  ));
                            },
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
                                    color: Colors.black54),
                                child: Text(
                                  document['name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
            floatingActionButton: Card(
              elevation: 20.0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                onTap: () {
                  print("*****");
                },
                child: Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black54),
                  child: const Center(
                    child: Icon(
                      Icons.message,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
