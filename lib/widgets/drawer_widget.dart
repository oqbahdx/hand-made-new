import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/products/add_product.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/navigators.dart';

class DrawerBuild extends StatefulWidget {
  const DrawerBuild({Key key}) : super(key: key);

  @override
  _DrawerBuildState createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    var model = HandCubit.get(context).userModel;
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! HandGetUserLoadingState,
          builder: (context) => Drawer(
              child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: h * 0.20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            maxRadius: 50,
                            child: model.profileImage != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('assets/pleaceholder.png'),
                                      image: NetworkImage(
                                        '${model.profileImage}',
                                      ),
                                      height: double.infinity,
                                      width: double.infinity,
                                    ))
                                : Image.asset('assets/personicon.png'),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                      Text(
                        '${model.name}',
                        style: normalText,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  height: h * 0.42,
                  child: model.role == "seller"
                    ? GridView(
                  children: [
                    containerBuildTap(
                        text: 'Add Product',
                        onTap: () {
                          moveToPage(context, AddProduct.id);
                        }),
                    containerBuildTap(text: 'My Products', onTap: () {}),
                    containerBuildTap(text: 'My TimeLine', onTap: () {}),
                    containerBuildTap(text: 'Favorite', onTap: () {}),
                    containerBuildTap(text: 'Contact Us', onTap: () {}),
                  ],
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 5.0,
                  ),
                )
                    : GridView(
                  children: [
                    containerBuildTap(text: 'Favorite', onTap: () {}),
                    containerBuildTap(text: 'Contact Us', onTap: () {}),
                  ],
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 5.0,
                  ),
                ),),
                SizedBox(height: h * 0.15,),
                Container(
                    height: h * 0.08,
                    child: defaultButtonTap('LOGOUT', () {}),),
              ],
            ),
          )),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// Drawer drawerBuild(BuildContext context){
//
//   return Drawer(
//
//    child:Column(
//
//      children: [
//        const SizedBox(height: 50,),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: [
//          Stack(children: [
//            CircleAvatar(
//              backgroundColor: Colors.transparent,
//              maxRadius: 50,
//              child: Image.asset('assets/personicon.png'),
//            ),
//            Positioned(
//                bottom: 0,
//                right: 0,
//                child: GestureDetector(
//                    onTap: (){
//
//                    },
//                    child: const Icon(Icons.edit,color: Colors.white,))
//
//            ),
//          ],),
//          Text('name',style: normalText,),
//
//        ],),
//        const Divider(),
//        GridView(
//
//          children: [
//
//            containerBuildTap(text: 'Add Product',onTap:(){
//              moveToPage(context, AddProduct.id);
//            }),
//            containerBuildTap(text: 'My Products',onTap: (){}),
//            containerBuildTap(text: 'My TimeLine',onTap: (){}),
//            containerBuildTap(text: 'Favorite',onTap: (){}),
//            containerBuildTap(text: 'Contact Us',onTap: (){}),
//          ],
//          shrinkWrap: true, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,
//          childAspectRatio: 3/2,
//          crossAxisSpacing: 5.0,
//        ),
//
//        ),
//        const SizedBox(height: 210,),
//        defaultButtonTap('LOGOUT', (){}),
//      ],
//    )
//
//   );
// }
