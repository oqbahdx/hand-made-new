class ProductsModel {
  String name;
  String description;
  String price;
  String uId;
  String image;
  ProductsModel(
      {this.uId, this.name, this.description, this.price, this.image});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> addProduct() {
    return {
      'uId': uId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
