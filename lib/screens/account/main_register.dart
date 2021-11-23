import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/account/buyer_register.dart';
import 'package:hand_made_new/screens/account/login.dart';
import 'package:hand_made_new/screens/account/seller_register.dart';
import 'package:hand_made_new/state_management/cubit.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/navigators.dart';

class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({Key key}) : super(key: key);
  static String id = "RegisterMainPage";

  @override
  _RegisterMainPageState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  List<String> titles = ['Buyer Register', 'Seller Register'];

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => HandCubit(),
      child: BlocConsumer<HandCubit, HandMadeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: appBarWidget(
                action:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                elevation: 0.0,
                title: Text(
                  titles[HandCubit.get(context).index],
                  style: normalText,
                ),
              ),
              body: SingleChildScrollView(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: h * .70,
                      child: PageView(
                        onPageChanged: (int value) {
                          HandCubit.get(context).pageChanged(value);
                        },
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          BuyerRegisterPage(),
                          SellerRegisterPage(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: h * .18,
                      child: Column(
                        children: [
                          ConditionalBuilder(condition: state is !HandSellerRegisterLoadingState
                              , builder: (context)=> containerBuildTap(
                                text: 'Register',
                                onTap: () async {

                                    await   HandCubit.get(context).sellerRegister(
                                        email: 'oqbahdx@gmail.com',
                                        password: '123456');
                                    print(HandCubit.get(context).emailController.text);
                                    print(HandCubit.get(context).passwordController.text);

                                }),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),),
                          SizedBox(
                            height: h * .035,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'You have already account ? ',
                                style: normalText,
                              ),
                              gradientText(
                                  text: 'LOGIN',
                                  onTap: () {
                                    moveToPageAndFinish(
                                        context, const LoginPage());
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
