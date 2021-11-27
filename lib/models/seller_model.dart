class SellerModel {
  String uid;
  String name;
  String email;
  String phone;
  String isAvailable;
  double longitude;
  double latitude;
  String profileImage;


  SellerModel(
      {this.uid,
      this.name,
      this.email,
      this.phone,
      this.isAvailable,
      this.longitude,this.latitude,this.profileImage});
  SellerModel.fromJson(Map<dynamic,dynamic>json){
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isAvailable = json['isAvailable'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    profileImage = json['profileImage'];
  }
  Map<String,dynamic>toJson(){
    return {
      'uid':uid,
      'name':name,
      'email':email,
      'phone':phone,
      'isAvailable':isAvailable,
      'longitude':longitude,
      'latitude':latitude,
      'profileImage':profileImage
    };
  }
}
