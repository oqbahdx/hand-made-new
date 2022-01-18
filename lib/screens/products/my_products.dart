import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/models/products_model.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class MyProducts extends StatefulWidget {
  static String id = "MyProducts";

  const MyProducts(
      {Key key,
      this.sellerName,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productsCategory})
      : super(key: key);
  final String sellerName;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productsCategory;

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  ProductsModel productsModel;
  List<ProductsModel> products= [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getMyProducts();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: appBarWidget(
              title: const Text(
                'My Products',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              action: Container(),
              elevation: 20.0),
          body: Container(
            padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColor,
              ),
            ),
            child: ConditionalBuilder(
              condition: HandCubit.get(context).myProducts.isNotEmpty,
              builder: (context)=>FutureBuilder(
                future: HandCubit.get(context).getMyProducts(),
                builder: (context,index)=>GridView.builder(gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2.9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 45),
                    itemBuilder: (context,index)=>GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return Scaffold(
                            appBar: appBarWidget(
                              title: Text(HandCubit.get(context).myProducts[index].name,style: const TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              action: Container(),
                              elevation: 20.0
                            ),
                            body: Column(
                              children: [
                                Hero(
                                  tag: 'key',
                                  child: FadeInImage(
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                    image: NetworkImage(HandCubit.get(context).myProducts[index].image),
                                    placeholder: const AssetImage('assets/pleaceholder.png'),
                                  ),

                                ),
                                const SizedBox(height: 30,),
                                Text(HandCubit.get(context).myProducts[index].description)
                              ],
                            )
                          );
                        }));
                      },
                      child: buildProductsItem(
                        HandCubit.get(context).myProducts[index],
                        'key',
                      ),
                    ),itemCount: HandCubit.get(context).myProducts.length,)
              ),
              fallback: (context)=>const Center(child: Text('No Products',style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),),),
            ),
          ),
        );
      },
    );
  }
}
