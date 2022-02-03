import 'package:flutter/material.dart';
import 'package:hand_made_new/components/video_player.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key key}) : super(key: key);
  static String id = "ChatList";

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
          child: Center(
            child: VideoPlayerItem(
              videoPlayerController: VideoPlayerController.network(
                  'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
              autoplay: true,
              looping: true,
            ),
          ),
        ),
        floatingActionButton: Card(
          elevation: 20.0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
  }
}
