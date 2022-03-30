import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productDes;
  final String productImage;

  const ProductDetails({
    Key key,
    this.productId,
    this.productPrice,
    this.productDes,
    this.productImage,
    this.productName,
  }) : super(key: key);
  static String id = "ProductDetails";

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {
        if (state is HandDeleteProductSuccess) {
          showMessageError('the product has been deleted successfully');
        }
        if (state is HandAddToFavoriteSuccess) {
          showMessageSuccess('item has been added successfully');
        }
      },
      builder: (context, state) {
        var list = HandCubit.get(context).favoritesList;
        bool exists =
            list.any((element) => element.productId == widget.productId);
        return Scaffold(
          appBar: appBarWidget(
              elevation: 0.0,
              action: Container(),
              title: Text(
                widget.productName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: gradientColor,
            )),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 20.0,
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    HandCubit.get(context).addToFavorite(
                                      userId:
                                          FirebaseAuth.instance.currentUser.uid,
                                      name: widget.productName,
                                      image: widget.productImage,
                                      des: widget.productDes,
                                      price: widget.productPrice,
                                      productId: widget.productId,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 40,
                                    color: Colors.white70,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: exists
                                    ? IconButton(
                                        onPressed: () {
                                          HandCubit.get(context)
                                              .deleteFavoriteItem(
                                                  productId: widget.productId);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_outlined,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          HandCubit.get(context).addToFavorite(
                                            userId: FirebaseAuth
                                                .instance.currentUser.uid,
                                            name: widget.productName,
                                            image: widget.productImage,
                                            des: widget.productDes,
                                            price: widget.productPrice,
                                            productId: widget.productId,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        widget.productName,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Hero(
                          tag: widget.productId,
                          child: CachedNetworkImage(
                            imageUrl: widget.productImage,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => Image.asset(
                                'assets/pleaceholder.png',
                                color: Colors.black87),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        color: Colors.white70,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.productPrice.toString() + " GSD",
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: Colors.white70,
                        ),
                        height: 172,
                        child: Center(
                            child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.productDes,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // HandCubit.get(context).deleteProduct(id: widget.productId);
              // Navigator.of(context).pop();
              showDeleteConfirmation(
                  context: context,
                  productName: widget.productName,
                  cancelFun: () {
                    Navigator.of(context).pop();
                  },
                  confirmFun: () {
                    HandCubit.get(context).deleteProduct(id: widget.productId);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StartPage()));
                  });
            },
            backgroundColor: Colors.black45,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
