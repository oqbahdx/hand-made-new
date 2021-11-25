class SellerModel {
  String uid;
  String name;
  String email;
  String phone;
  String isAvailable;
  String location;
  String profileImage;


  SellerModel(
      {this.uid,
      this.name,
      this.email,
      this.phone,
      this.isAvailable,
      this.location,this.profileImage});
  SellerModel.fromJson(Map<String,dynamic>json){
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isAvailable = json['isAvailable'];
    location = json['location'];
    profileImage = json['profileImage'];
  }
  Map<String,dynamic>toJson(){
    return {
      'uid':uid,
      'name':name,
      'email':email,
      'phone':phone,
      'isAvailable':isAvailable,
      'location':location,
      'profileImage':profileImage
    };
  }
}
