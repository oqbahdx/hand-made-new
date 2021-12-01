class BuyerModel {
  String uid;
  String name;
  String email;
  String profileImage;

  BuyerModel({this.name, this.email, this.profileImage,this.uid});

  BuyerModel.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }
}
