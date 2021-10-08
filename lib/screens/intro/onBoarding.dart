import 'package:flutter/material.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/on_boarding_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  static String id = "OnBoarding";



  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<String> images = [
    'assets/onboarding1.png',
    'assets/onboarding2.png',
    'assets/onboarding3.png'
  ];
  List<String> titles = [
    'title1',
    'title2',
    'title3',
  ];
  List<String> bodies = [
    'body1',
    'body2',
    'body3',
  ];

   PageController pageController = PageController();
   bool isLast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
        elevation: 0.0,
        action: TextButton(onPressed: (){}, child:Text(
          'close',style: TextStyle(
          fontSize: 18,
          color: onBoardingColor
        ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
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

                      print('last');
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
                  effect: WormEffect(
                      spacing: 5,
                      dotHeight: 10,
                      dotWidth: 25,
                      activeDotColor: onBoardingColor),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: onBoardingColor,
                  onPressed: () {
                    if (isLast) {
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCubic);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
