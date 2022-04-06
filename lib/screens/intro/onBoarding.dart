import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hand_made_new/components/floating_buttons.dart';
import 'package:hand_made_new/screens/account/login.dart';
import 'package:hand_made_new/storage/shared.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:hand_made_new/widgets/on_boarding_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  static String id = "OnBoarding";

  const OnBoarding({Key key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  void submit() {
    SharedPref.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        moveToPageAndFinish(context, const LoginPage());
      }
    });
  }

  List<String> images = [
    'assets/onboarding1.png',
    'assets/onboarding2.png',
    'assets/onboarding3.png'
  ];
  List<String> titles = [
    'Hand Made App',
    'Around You',
    'Clean Food',
  ];
  List<String> bodies = [
    'application for families who is made their food in house ',
    'find a families are near by you and see their location in the map',
    'Your health is important and you will eat a clean food',
  ];

  PageController pageController = PageController();
  bool isLast = false;

  getPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.locationWhenInUse,
      Permission.location,
      Permission.locationAlways,
      Permission.camera,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0,end: 255.0),
      duration: const Duration(milliseconds: 20000),
      builder: (context,hue,child){
        final vhsColor = HSVColor.fromAHSV(1.0, hue,1.0, 1.0);
        return  Scaffold(
          body: Container(
              color: vhsColor.toColor(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => onBoardingWidget(
                        images[index],
                        titles[index],
                        bodies[index],
                      ),
                      itemCount: 3,
                      controller: pageController,
                      onPageChanged: (int index) {
                        if (index == 2) {
                          setState(() {
                            isLast = true;

                            if (kDebugMode) {
                              print('last');
                            }
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: const WormEffect(
                            spacing: 5,
                            dotHeight: 10,
                            dotWidth: 25,
                            activeDotColor: onBoardingColor),
                      ),
                      const Spacer(),
                      isLast == false
                          ? floatingNextButton(
                          function: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInCubic);
                          },
                          icn: Icons.arrow_forward_ios)
                          : floatingNextButton(
                          function: () async {
                            submit();
                            if (await Permission.location.isGranted &&
                                await Permission
                                    .accessMediaLocation.isGranted &&
                                await Permission.locationAlways.isGranted &&
                                await Permission.camera.isGranted &&
                                await Permission.storage.isGranted) {
                              moveToPageAndFinish(context, const LoginPage());
                            }
                          },
                          icn: Icons.home),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
