
class UserData{
  final String message;
  final String token;
  final UserModel user;

  UserData({required this.message,required this.token,required this.user});

  static UserData fromJson(Map<String,dynamic> json) {
    return UserData(message: json["message"], token: json["token"],user: UserModel.fromJson(json["user"]));
  }
}


class UserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String? userPic;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.userPic,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      userPic: json["user_pic"],
    );
  }
}
