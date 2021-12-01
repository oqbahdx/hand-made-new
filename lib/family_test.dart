// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hand_made_new/components/containers.dart';
// import 'package:hand_made_new/models/seller_model.dart';
//
// class FamilyTest extends StatelessWidget {
//   FamilyTest({Key key}) : super(key: key);
//
//   List<SellerModel> sellers = [];
//   SellerModel model;
//
//   Future getAllSellers() {
//     FirebaseFirestore.instance
//         .collection('sellers')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         print(doc["name"]);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView.builder(
//           itemBuilder: (context, index) => familiesContainer(sellers[index],context),
//           itemCount: sellers.length,
//         ),
//       ),
//     );
//   }
// }
