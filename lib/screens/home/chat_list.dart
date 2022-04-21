import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/chat/seller_chat.dart';
import 'package:hand_made_new/styles/colors.dart';
import '../../components/navigator.dart';


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
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').get(const GetOptions(source: Source.cache)),
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
                      // final dynamic data = document.data();
                      // print("data : ${data}");
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            moveToPageWithData(
                              context,
                              namePage: SellerChat(
                                image: document['profileImage'],
                                name: document['name'],
                                uid: document['uid'],
                              ),
                            );
                          },
                          child: Card(
                            elevation: 20.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Hero(
                                      tag: document['uid'],
                                      transitionOnUserGestures: true,
                                      child: Container(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(150),

                                        ),
                                          height: 80,
                                          width: 80,
                                          child: CachedNetworkImage(
                                            imageUrl: document['profileImage'],
                                            fit: BoxFit.fill,
                                            height: double.infinity,
                                            width: double.infinity,
                                            placeholder: (context, url) =>
                                                Image.asset('assets/pleaceholder.png',
                                                    color: Colors.black87),
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                          )),
                                    ),
                                    Text(
                                      document['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        );
      },
    );
  }
}
