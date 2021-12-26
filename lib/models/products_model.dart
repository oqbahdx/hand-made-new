class ProductsModel{
  String name;
  String description;
  String price;
  String calories;
  String categories;
  String image;
  ProductsModel(
      {this.name,
      this.description,
      this.price,
      this.calories,
      this.categories,
      this.image});

  ProductsModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    description = json['description'];
    price = json['price'];
    calories = json['calories'];
    categories = json['categories'];
    image = json['image'];
  }

  Map<String,dynamic> addProduct(){
    return {
      'name':name,
      'description':description,
      'price':price,
      'calories':calories,
      'categories':categories,
      'image':image,
    };
}


}

