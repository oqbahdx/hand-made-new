import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/text_forms.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  static String id = "Profile";

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
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HandCubit.get(context).userModel;
        nameController.text = model.name;
        emailController.text = model.email;
        return ConditionalBuilder(
          condition: state is! HandGetCurrentUserLoadingState,
          builder: (context) => Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '${model.profileImage}',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: nameController,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: emailController,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Switch.adaptive(value: model.isAvailable,
                        onChanged: (value){

                        }),
                    SizedBox(
                      height: 20,
                    ),
                    containerBuildTap(
                      text: 'UPDATE',
                      h: 60
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
