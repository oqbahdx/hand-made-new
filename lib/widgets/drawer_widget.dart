import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/screens/account/login.dart';
import 'package:hand_made_new/screens/drawer/contact_us.dart';
import 'package:hand_made_new/screens/drawer/favorite.dart';
import 'package:hand_made_new/screens/home/chat_list.dart';
import 'package:hand_made_new/screens/products/add_product.dart';
import 'package:hand_made_new/screens/products/my_products.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:hand_made_new/storage/shared.dart';

class DrawerBuild extends StatefulWidget {
  const DrawerBuild({Key key}) : super(key: key);

  @override
  _DrawerBuildState createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
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
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                                      placeholder: const AssetImage(
                                          'assets/pleaceholder.png'),
                                      image: NetworkImage(
                                        model.profileImage,
                                      ),
                                      height: double.infinity,
                                      width: double.infinity,
                                    ))
                                : Image.asset('assets/pleaceholder.png',color: Colors.black,),
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
                        model.name,
                        style: normalText,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: h * 0.42,
                  child: model.role == "seller"
                      ? GridView(
                          children: [
                            buildTapBlack(
                                text: 'Add Product',
                                onTap: () {
                                  moveToPage(context, AddProduct.id);
                                }),
                            buildTapBlack(
                                text: 'My Products',
                                onTap: () {
                                  moveToPage(context, MyProducts.id);
                                }),
                            buildTapBlack(
                                text: 'My TimeLine',
                                onTap: () {
                                  moveToPage(context, ChatList.id);
                                }),
                            buildTapBlack(
                                text: 'Favorite',
                                onTap: () {
                                  moveToPage(context, FavoritePage.id);
                                }),
                            buildTapBlack(
                                text: 'Contact Us',
                                onTap: () {
                                  moveToPage(context, ContactUs.id);
                                }),
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
                            buildTapBlack(text: 'Favorite', onTap: () {}),
                            buildTapBlack(
                                text: 'Contact Us',
                                onTap: () {
                                  moveToPage(context, ContactUs.id);
                                }),
                          ],
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 5.0,
                          ),
                        ),
                ),
                SizedBox(
                  height: h * 0.15,
                ),
                SizedBox(
                  height: h * 0.08,
                  child: buildTapBlack(
                      text: 'LOGOUT',
                      onTap: () async {
                        await   FirebaseAuth.instance.currentUser.delete();
                        await SharedPref.removeData(key: uId);
                        moveToPageAndFinish(context, const LoginPage());
                      }),
                ),
              ],
            ),
          )),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
