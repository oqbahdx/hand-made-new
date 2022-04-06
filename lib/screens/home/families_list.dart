import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    HandCubit.get(context).getCurrentUser();
    HandCubit.get(context).getAllFavorites();
    HandCubit.get(context).getSellers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HandCubit.get(context).userModel;
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is !HandGetUserSuccessState,
            builder: (context)=>Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColor,
                  )),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('isAvailable', isEqualTo: true)
                    .where('role', isEqualTo: 'seller')
                    .limit(10)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      final dynamic data = document.data();
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            moveToPageWithData(context,
                                namePage: SellerDetails(
                                  uId: data['uid'].toString(),
                                  name: data['name'].toString(),
                                  image: data['profileImage'].toString(),
                                ));
                          },
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
                                document['name'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            fallback: (context)=>Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColor
                )
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            ),
          ),
        );
      },
    );
  }
}
