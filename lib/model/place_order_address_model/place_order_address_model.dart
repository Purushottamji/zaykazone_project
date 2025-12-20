// class PlaceOrderAddressModel {
//   final int id;
//   final int userId;
//   final String landMark;
//   final String state;
//   final String pinCode;
//   final String district;
//   final String mobileNumber;
//   final String fullAddress;
//
//
//   PlaceOrderAddressModel({
//     required this.id,
//     required this.userId,
//     required this.landMark,
//     required this.state,
//     required this.pinCode,
//     required this.district,
//     required this.mobileNumber,
//     required this.fullAddress,
//   });
//
//    factory PlaceOrderAddressModel.fromJson(Map<String, dynamic> json) {
//     return PlaceOrderAddressModel(
//       id: json['id'],
//       userId: json['user_id'],
//       landMark: json['land_mark'],
//       state: json['state'],
//       pinCode: json['pin_code'],
//       district: json['district'],
//       mobileNumber: json['mobile_number'],
//       fullAddress: json['full_address'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'land_mark': landMark,
//       'state': state,
//       'pin_code': pinCode,
//       'district': district,
//       'mobile_number': mobileNumber,
//       'full_address': fullAddress,
//     };
//   }
// }
// class PlaceOrderUpdateAddressModel {
//   final String message;
//   final UpdatedData updatedData;
//
//   PlaceOrderUpdateAddressModel({
//     required this.message,
//     required this.updatedData,
//   });
//
//   factory PlaceOrderUpdateAddressModel.fromJson(Map<String, dynamic> json) {
//     return PlaceOrderUpdateAddressModel(
//       message: json['message'],
//       updatedData: UpdatedData.fromJson(json['updated_data']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'updated_data': updatedData.toJson(),
//     };
//   }
// }
//
// class UpdatedData {
//   final int id;
//   final int userId;
//   final String landMark;
//   final String state;
//   final String pinCode;
//   final String district;
//   final String mobileNumber;
//   final String fullAddress;
//
//   UpdatedData({
//     required this.id,
//     required this.userId,
//     required this.landMark,
//     required this.state,
//     required this.pinCode,
//     required this.district,
//     required this.mobileNumber,
//     required this.fullAddress,
//   });
//
//   factory UpdatedData.fromJson(Map<String, dynamic> json) {
//     return UpdatedData(
//       id: json["id"] ?? 0,
//       userId: json["user_id"] ?? 0,
//       landMark: json["land_mark"] ?? "",
//       state: json["state"] ?? "",
//       pinCode: json["pin_code"] ?? "",
//       district: json["district"] ?? "",
//       mobileNumber: json["mobile_number"] ?? "",
//       fullAddress: json["full_address"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'land_mark': landMark,
//       'state': state,
//       'pin_code': pinCode,
//       'district': district,
//       'mobile_number': mobileNumber,
//       'full_address': fullAddress,
//     };
//   }
// }
//


class PlaceOrderAddressModel {
  final int id;
  final int userId;
  final String landMark;
  final String state;
  final String pinCode;
  final String district;
  final String mobileNumber;
  final String fullAddress;

  PlaceOrderAddressModel({
    required this.id,
    required this.userId,
    required this.landMark,
    required this.state,
    required this.pinCode,
    required this.district,
    required this.mobileNumber,
    required this.fullAddress,
  });

  factory PlaceOrderAddressModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderAddressModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      landMark: json['land_mark'] ?? "",        // 🔥 NULL SAFE
      state: json['state'] ?? "",
      pinCode: json['pin_code'] ?? "",
      district: json['district'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      fullAddress: json['full_address'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'land_mark': landMark,
      'state': state,
      'pin_code': pinCode,
      'district': district,
      'mobile_number': mobileNumber,
      'full_address': fullAddress,
    };
  }
}
