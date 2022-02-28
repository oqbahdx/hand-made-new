class FavoriteModel {
  String userId;
  String productId;
  String productName;
  String productPrice;
  String productDes;
  String productImage;
  bool isFavorite;

  FavoriteModel(
      {this.userId,
        this.productId,
      this.productDes,
      this.productPrice,
      this.productName,
      this.productImage,
      this.isFavorite});

  FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productDes = json['productDes'];
    productImage = json['productImage'];
    isFavorite = json['isFavorite'];
  }

  toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productDes': productDes,
      'productPrice': productPrice,
      'isFavorite': isFavorite,
    };
  }
}
