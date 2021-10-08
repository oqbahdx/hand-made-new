import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/time_line.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/drawer_widget.dart';
import 'package:hand_made_new/widgets/start_widget.dart';

import 'families_list.dart';
import 'map.dart';

class StartPage extends StatefulWidget {
  static String id = "StartPage";

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int currentIndex = 1;
  List<Widget> homePages = [FamiliesList(), MapPage(), TimeLine(), Profile()];
  List<String> titles = ['Families List','Map','TimeLine','Account'];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HandCubit(),
      child: BlocConsumer<HandCubit,HandMadeState>(
        listener: (context,state){},
        builder: (context,state){
         return Directionality(
           textDirection: TextDirection.rtl,
           child: Scaffold(
             appBar: appBarWidget(
               title: Text(titles[HandCubit.get(context).pageIndex],style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontFamily: 'Amiri'
               ),),
               elevation: 0.0,
               action: Container()
             ),
               body: Center(
                 child: homePages.elementAt(HandCubit.get(context).pageIndex),
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
                         child: startBottomNav(
                             index: HandCubit.get(context).pageIndex,
                             function: (index){
                               HandCubit.get(context).changeIndex(index);
                             },
                               gButton: [
                               gButtonNav(icon: Icons.home, text: 'home'),
                               gButtonNav(icon: Icons.map, text: 'map'),
                               gButtonNav(
                                   icon: Icons.ten_k_outlined, text: 'time line'),
                               gButtonNav(icon: Icons.person, text: 'profile'),
                             ])),
                   )),drawer: drawerBuild(),),
         );
        },

      ),
    );
  }
}
