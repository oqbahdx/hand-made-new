import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/chat_list.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/drawer_widget.dart';
import 'package:hand_made_new/widgets/start_widget.dart';

import 'families_list.dart';
import 'map.dart';

class StartPage extends StatefulWidget {
  static String id = "StartPage";

  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int currentIndex = 1;
  List<Widget> homePages = [
    const Profile(),
    const MapPage(),
    const ChatList(),
    const FamiliesList()
  ];
  List<String> titles = [
    'Profile',
    'Map',
    'Chats',
    'Families List',
  ];
  @override
  Widget build(BuildContext context) {

      return BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: appBarWidget(
                  title: Text(titles[HandCubit.get(context).pageIndex],
                      style: appBarStyle),
                  elevation: 0.0,
                  action: Container()),
              body: Center(
                child: homePages.elementAt(HandCubit.get(context).pageIndex),
              ),
              bottomNavigationBar: Container(
                height: 70,
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor)

                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12),
                      child: startBottomNav(
                          index: HandCubit.get(context).pageIndex,
                          function: (index) {
                            HandCubit.get(context).changeIndex(index);
                          },
                          gButton: [
                            gButtonNav(icon: Icons.person, text: 'PROFILE'),
                            gButtonNav(icon: Icons.map, text: 'MAP'),
                            gButtonNav(
                                icon: Icons.message,
                                text: 'CHATS'),
                            gButtonNav(icon: Icons.group, text: 'FAMILIES'),
                          ]))),
              drawer: const DrawerBuild(),
            ),
          );
        },
    );
  }
}
