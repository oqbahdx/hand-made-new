import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
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
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HandCubit, HandMadeState>(

        listener: (context,state){
          if(state is HandUpdateProfileWithImageSuccess){
            showMessageSuccess('The Profile Has been Updated Successfully');
          }
        },
        builder: (context, state) {

      var model = HandCubit.get(context).userModel;
      if(model.name == null){
        return const CircularProgressIndicator();
      }else{
        nameController.text = model.name;
        phoneController.text = model.phone;
        bool isOnline = model.isAvailable;
        return ConditionalBuilder(
          condition: state is! HandGetCurrentUserLoadingState,
          builder: (context) => Scaffold(
            body: Container(
              decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .04,
                    ),
                    Stack(
                      children: [
                        HandCubit.get(context).image == null
                            ? Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: Colors.black54,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: model.profileImage,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width : double.infinity,
                            placeholder: (context, url) => Image.asset('assets/pleaceholder.png',color: Colors.white),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        )
                            : Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: Colors.black54,
                          ),
                          child: Image.file(
                            HandCubit.get(context).image,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                showDialogBuild(context);
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    buildTextFormFieldWithBackground(controller: nameController),
                    SizedBox(
                      height: height * .05,
                    ),
                    buildTextFormFieldWithBackground(controller: phoneController),
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
                            value: model.isAvailable,
                            onChanged: (bool value) {
                              setState(() {
                                model.isAvailable = value;
                              });
                            }),
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
                    ConditionalBuilder(
                      condition: state is! HandUpdateProfileWithImageLoading,
                      builder: (context) => buildTapBlack(
                          text: 'UPDATE',
                          h: 60,
                          onTap: () {
                            HandCubit.get(context).image.path != null
                                ? HandCubit.get(context).updateProfileWithImage(
                                uid: model.uid,
                                role: model.role,
                                isAvailable: model.isAvailable,
                                name: nameController.text,
                                email: model.email,
                                password: model.password,
                                phone: phoneController.text,
                                location: model.location,
                                )
                                : HandCubit.get(context).updateProfile(
                                image: model.profileImage,
                                name: nameController.text,
                                email: model.email,
                                isAvailable: model.isAvailable,
                                location: model.location,
                                password: model.password,
                                phone: phoneController.text,
                                role: model.role,
                                uid: model.uid);
                          }),
                      fallback: (context) => Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: gradientColor)),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Container(
            decoration:
            BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      }

    });
  }
}
