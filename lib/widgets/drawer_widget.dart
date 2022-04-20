import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
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
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight:Radius.circular(15),topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),bottomLeft:Radius.circular(15)
                          )
                        ),
                        child: CachedNetworkImage(
                          imageUrl: model.profileImage,
                          fit: BoxFit.fill,
                          height: double.infinity,
                          width : double.infinity,
                          placeholder: (context, url) => Image.asset('assets/pleaceholder.png',color: Colors.white,),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
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
                  child:
                    GridView(
                          children: [
                            model.role == "seller"?BuildTapBlack(
                                text: 'Add Product',
                                onTap: () {
                                  moveToPage(context, AddProduct.id);
                                }):Container(),
                            model.role == "seller"?BuildTapBlack(
                                text: 'My Products',
                                onTap: () {
                                  moveToPage(context, MyProducts.id);
                                }):Container(),
                            BuildTapBlack(
                                text: 'Favorite',
                                onTap: () {
                                  moveToPage(context, FavoritePage.id);
                                }),
                            BuildTapBlack(
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

                ),
                SizedBox(
                  height: h * 0.15,
                ),
                SizedBox(
                  height: h * 0.08,
                  child: BuildTapBlack(
                      text: 'LOGOUT',
                      onTap: () async {
                        SharedPref.removeData(key: 'uid');
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
