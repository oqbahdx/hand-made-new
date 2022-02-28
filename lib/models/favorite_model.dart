class FavoriteModel {
  String userId;
  String productName;

  String productImage;
  bool isFavorite;

  FavoriteModel(
      {this.userId,

      this.productName,
      this.productImage,
      this.isFavorite});

  FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];

    productName = json['productName'];
    productImage = json['productImage'];
    isFavorite = json['isFavorite'];
  }

  toJson() {
    return {
      'userId': userId,
      'productName': productName,
      'productImage': productImage,
      'isFavorite': isFavorite,
    };
  }
}
