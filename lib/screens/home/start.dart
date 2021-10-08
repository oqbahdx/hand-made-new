import 'package:flutter/material.dart';

import 'package:hand_made_new/screens/home/families_list.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/time_line.dart';
import 'package:hand_made_new/widgets/start_widget.dart';

import 'map.dart';

class StartPage extends StatefulWidget {
  static String id = "StartPage";

  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Widget> homePages = [FamiliesList(), MapPage(), TimeLine(), Profile()];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: homePages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child:startBottomNav(
                  index: _selectedIndex,
                  function: (index){
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  gButton: [
                    gButtonNav(
                      icon: Icons.home,
                      text:'home'
                    ),
                    gButtonNav(
                        icon: Icons.map,
                        text:'map'
                    ),
                    gButtonNav(
                        icon: Icons.ten_k_outlined,
                        text:'time line'
                    ),
                    gButtonNav(
                        icon: Icons.person,
                        text:'profile'
                    ),
                  ]
                )
              ),
            )));
  }
}
