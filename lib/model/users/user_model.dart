class UserModel {
  String name;
  String email;
  BigInt mobile;
  String password;
  String? imageUrl;

  UserModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    this.imageUrl
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      password: json["password"],
      imageUrl: json["user_pic"]
    );
  }
}
