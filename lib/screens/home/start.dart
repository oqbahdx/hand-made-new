import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/time_line.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
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
    const TimeLine(),
    const FamiliesList()
  ];
  List<String> titles = [
    'Profile',
    'Map',
    'TimeLine',
    'Families List',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandCubit()..getSellers()..getCurrentUser(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: appBarWidget(
                    title: Text(titles[HandCubit.get(context).pageIndex],
                        style: normalText),
                    elevation: 20.0,
                    action: Container()),
                body: Center(
                  child: homePages.elementAt(HandCubit.get(context).pageIndex),
                ),
                bottomNavigationBar: Container(
                  height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(.1),
                        )
                      ],
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
                              gButtonNav(icon: Icons.person, text: 'profile'),
                              gButtonNav(icon: Icons.map, text: 'map'),
                              gButtonNav(
                                  icon: Icons.ten_k_outlined,
                                  text: 'time line'),
                              gButtonNav(icon: Icons.group, text: 'families'),
                            ]))),
                drawer: const DrawerBuild(),
              ),
            ),
          );
        },
      ),
    );
  }
}
