import 'dart:async';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/message_widget.dart';

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
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getMessages();
  }
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 0), () =>
        listScrollController.jumpTo(
            listScrollController.position.maxScrollExtent));
    return Builder(builder: (context) {
      return BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HandCubit.get(context).getMessages(receiverId: widget.uid);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: appBarWidget(
                title: Text(
                  widget.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                elevation: 20.0,
                action: Image.network(widget.image)),
            body: ConditionalBuilder(
              condition: HandCubit
                  .get(context)
                  .messages
                  .length > 0,
              builder: (context) =>
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        children: [
                          Expanded(
                            child: ListView.separated(
                                controller: listScrollController,

                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var message = HandCubit
                                      .get(context)
                                      .messages[index];
                                  if (widget.uid == message.receiverId) {
                                    return receiveMessage(message);
                                  }
                                  return sendMessage(message);
                                },
                                separatorBuilder: (context,
                                    index) => const SizedBox(height: 10,),
                                itemCount: HandCubit
                                    .get(context)
                                    .messages
                                    .length),
                          ),
                          Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black, width: 2)),
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
                                ConditionalBuilder(
                                  condition: state is! HandSendMessageLoading,
                                  builder: (context) =>
                                      IconButton(
                                        onPressed: () {
                                          if (messageController.text == '') {
                                            showMessageError(
                                                'please enter text');
                                          } else {
                                            HandCubit.get(context).sendMessage(
                                              text: messageController.text,
                                              receiverId: widget.uid,
                                              date: DateTime.now().toString(),
                                            );
                                            messageController.text = '';
                                          }
                                        },
                                        icon: const Icon(Icons.send),
                                        iconSize: 35,
                                      ),
                                  fallback: (context) =>
                                  const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              fallback: (context) => Container(

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColor,

                  ),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .35,),
                   const Text("No Messages Here",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50
                    ),),
                   const Spacer(),
                    Container(

                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: gradientColor
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black, width: 2)),
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
                          ConditionalBuilder(
                            condition: state is! HandSendMessageLoading,
                            builder: (context) =>
                                IconButton(
                                  onPressed: () {
                                    if (messageController.text == '') {
                                      showMessageError(
                                          'please enter text');
                                    } else {
                                      HandCubit.get(context).sendMessage(
                                        text: messageController.text,
                                        receiverId: widget.uid,
                                        date: DateTime.now().toString(),
                                      );
                                      messageController.text = '';
                                    }
                                  },
                                  icon: const Icon(Icons.send),
                                  iconSize: 35,
                                ),
                            fallback: (context) =>
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
