import 'package:flutter/material.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key key,this.tag}) : super(key: key);
  final Object tag;
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    var model = HandCubit.get(context).productsModel;
    return Scaffold(
      appBar: appBarWidget(
        elevation: 20.0,
        action: Container(),
        title: null
      ),
      body: Hero(
        tag: 'key',
        child: FadeInImage(
          width: double.infinity,
          fit: BoxFit.fitWidth,
          image: NetworkImage(model.image),
          placeholder: const AssetImage('assets/pleaceholder.png'),
        ),
      ),
    );
  }
}
