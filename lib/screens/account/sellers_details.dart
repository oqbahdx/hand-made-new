import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/models/seller_model.dart';
import 'package:hand_made_new/widgets/app_bar.dart';


class SellerDetails extends StatefulWidget {
  final String model;
  const SellerDetails({Key key,this.model,}) : super(key: key);
  static String id = "SellerDetails";

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  @override
  void initState() {
    HandCubit.get(context).getSeller();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: Text(widget.model),
          elevation: 0.0,
          action: Container()
      ),
    );
  }
}
