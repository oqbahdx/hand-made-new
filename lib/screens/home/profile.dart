import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  static String id ="Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    HandCubit.get(context).getCurrentUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HandCubit,HandMadeState>(
    listener: (context,state){},
    builder: (context,state){
      var model = HandCubit.get(context).userModel;
      return ConditionalBuilder(condition: state is !HandGetCurrentUserLoadingState,
          builder:(context)=>Scaffold(
            body: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("${model.name}")
                // CircleAvatar(
                //   // backgroundColor: Colors.grey,
                //     radius: 60,
                //     child: Image(
                //       image: NetworkImage(
                //           '${cubit.profileImage}'),
                //     )),
              ],
            ),
          ),
      fallback: (context)=>Center(child: CircularProgressIndicator(),),
      );
    },
    );
  }
}
