class UserModel {
  String uid;
  String name;
  String email;
  String password;
  String role;
  String phone;
  bool isAvailable;
  double longitude;
  double latitude;
  String profileImage;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.role,
      this.phone,
      this.isAvailable,
      this.longitude,
      this.latitude,
      this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isAvailable = json['isAvailable'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    profileImage = json['profileImage'];
    role = json['role'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'isAvailable': isAvailable,
      'latitude': latitude,
      'longitude': longitude,
      'profileImage': profileImage,
      'phone': phone,
      'role': role,
    };
  }
}
