import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/account/sellers_details.dart';
import 'package:hand_made_new/styles/colors.dart';

class FamiliesList extends StatefulWidget {
  const FamiliesList({Key key}) : super(key: key);

  @override
  _FamiliesListState createState() => _FamiliesListState();
}

class _FamiliesListState extends State<FamiliesList> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HandCubit.get(context).sellers.isNotEmpty,
          builder: (context) => Scaffold(
            body: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor)),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('/users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: gradientColor)),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      final userData = snapshot.data.data();

                      if (userData['role'] == 'seller') {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => familiesContainer(
                                model: HandCubit.get(context).sellers[index],
                                onTap: () {
                                  moveToPageWithData(context,
                                      namePage: SellerDetails(
                                        name: HandCubit.get(context)
                                            .sellers[index]
                                            .name,
                                        uId: HandCubit.get(context)
                                            .sellers[index]
                                            .uid,
                                      ));
                                }),
                            separatorBuilder: (context, index) => const SizedBox(
                                  height: 10,
                                ),
                            itemCount: HandCubit.get(context).sellers.length);
                      }

                      return Container();
                    })),
          ),
          fallback: (context) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
              ))),
        );
      },
    );
  }
}
