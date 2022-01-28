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
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = true;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = HandCubit.get(context).userModel;
          if (model.name == null) {
            const CircularProgressIndicator();
          } else {
            nameController.text = model.name;
            emailController.text = model.email;
          }

          return ConditionalBuilder(
            condition: state is! HandGetCurrentUserLoadingState,
            builder: (context) => Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor)),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .04,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            model.profileImage,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      buildTextFormFieldWithBackground(
                          controller: nameController),
                      SizedBox(
                        height: height * .05,
                      ),
                      buildTextFormFieldWithBackground(
                          controller: emailController),
                      SizedBox(
                        height: height * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'OFFLINE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Switch.adaptive(
                              value: model.isAvailable ,
                              onChanged: HandCubit.get(context).changeIsOnline(isOnline)),
                          const Text(
                            'ONLINE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      ConditionalBuilder(condition: state is !HandUpdateCurrentUserProfileLoading,
                          builder: (context)=>buildTapBlack(text: 'UPDATE', h: 60,onTap: (){
                            HandCubit.get(context).updateUser(
                                image: 'image',
                                name: nameController.text,
                                email: emailController.text,
                                isAvailable: isOnline);
                          }),
                      fallback: (context) => Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: gradientColor)),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }
}
