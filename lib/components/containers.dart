import 'package:flutter/material.dart';
import 'package:hand_made_new/models/user_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '/styles/colors.dart';
import '/styles/fonts.dart';

Widget containerBuildTap(
    {String text, Function onTap, double h = 50, double w = 600}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: containerStyle,
          ),
        ),
        height: h,
        width: w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            )),
      ),
    ),
  );
}

Widget defaultButtonTap(String text, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            text,
            style: containerStyle,
          ),
        ),
      ),
    ),
  );
}

Widget familiesContainer({UserModel model, Function onTap}) {
  return Center(
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: onTap,
            child: Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black54),
                child: Text(
                  model.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget positionedBuild({double h, double w, String txt}) {
  return SizedBox(
    height: h,
    width: w,
    child: Card(
      elevation: 20.0,
      color: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
          topLeft: Radius.circular(100),
        ),
      ),
      child: Center(
          child: Text(
        txt,
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    ),
  );
}

Widget buildProductsItem(model, Object tag) {
  return Container(
    // alignment: Alignment.center,
    child: Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          child: Hero(
            tag: tag,
            child: FadeInImage(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              image: NetworkImage(model.image),
              placeholder: const AssetImage('assets/pleaceholder.png'),
            ),
          ),
          height: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.name,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    ),
    height: 185,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black54,
    ),
  );
}

class BuildTapBlack extends StatelessWidget {
   BuildTapBlack({Key key,this.text,this.onTap,this.h,this.w}) : super(key: key);
final String text;
final Function onTap;
 double h = 50.0;
 double w = 600.0;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.transparent,
          child: Container(
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveValue(context,
                        defaultValue: 25.0,
                        valueWhen: [
                          const Condition.smallerThan(name: MOBILE, value: 20.0),
                          const Condition.smallerThan(name: TABLET, value: 40.0),
                        ]).value,
                    color: Colors.white),
              ),
            ),
            height: h,
            width: w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

// Widget buildTapBlack(
//     {String text, Function onTap, double h = 50, double w = 600}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Card(
//         elevation: 20.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         color: Colors.transparent,
//         child: Container(
//           child: Center(
//             child: Text(
//               text,
//               textAlign: TextAlign.center,
//               style:  TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: ResponsiveValue( context,defaultValue: 25.0,valueWhen: [
//                   Condition.smallerThan(name: MOBILE,value: 20),
//                   Condition.smallerThan(name: TABLET,value: 40),
//                 ]).value,
//                 color: Colors.white
//               ),
//             ),
//           ),
//           height: h,
//           width: w,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10), color: Colors.black54),
//         ),
//       ),
//     ),
//   );
// }

Widget favoriteBuild({String name, String image, String tag}) {
  return Card(
    elevation: 20.0,
    shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(15)),
    color: Colors.black54,
    shadowColor: Colors.red,
    child: Center(
      child: ListTile(
        tileColor: Colors.black54,
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(15)),
          child: Hero(
            tag: tag,
            child: Image.network(
              image,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        trailing: const Icon(
          Icons.favorite_outlined,
          size: 40,
          color: Colors.red,
        ),
      ),
    ),
  );
}

Widget registerCard({BuildContext context, String text, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 5),
            gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            )),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 45),
        ),
      ),
    ),
  );
}
