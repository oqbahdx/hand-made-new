import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/account/main_register.dart';
import 'package:hand_made_new/screens/account/otp.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:hand_made_new/widgets/text_from_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static String id = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HandCubit(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: appBarWidget(
                title: Text(
                  'Login',
                  style: normalText,
                ),
                elevation: 0.0,
                action: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
              ),
              body: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 250,
                    width: 350,
                    child: Image.asset('assets/applogo.png'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultTextFormField(
                      text: 'email',
                      showPass: null,
                      sec: false,
                      function: null,
                      controller: null,
                      icn: Icons.email,
                      type: TextInputType.emailAddress),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      text: 'password',
                      showPass: IconButton(
                          onPressed: () {
                            HandCubit.get(context).changePasswordVisibility();
                          },
                          icon: Icon(HandCubit.get(context).icon)),
                      sec: HandCubit.get(context).isShow,
                      function: null,
                      controller: null,
                      icn: Icons.enhanced_encryption,
                      type: TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Forget password  ?',style:smallText,),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: gradientText(text: 'Click Here',onTap: (){
                         moveToPage(context, OTPPage.id);
                      }),
                    )
                  ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  containerBuildTap(text: 'Login', onTap: () {}),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'You have already account ? ',
                        style: normalText,
                      ),
                      gradientText(
                          text: 'REGISTER',
                          onTap: () {
                            moveToPageAndFinish(context, RegisterMainPage());
                          })
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }
}
