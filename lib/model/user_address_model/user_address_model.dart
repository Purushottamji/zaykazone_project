class UserAddressModel {
  final int addId;
  final String labelAs;
  final String fullAddress;
  final String street;
  final String pinCode;
  final String apartmentNo;
  final String buildingNo;
  final int userId;

  UserAddressModel({
    required this.addId,
    required this.labelAs,
    required this.fullAddress,
    required this.street,
    required this.pinCode,
    required this.apartmentNo,
    required this.buildingNo,
    required this.userId,
  });

  static UserAddressModel fromJson(Map<String, dynamic> json) {
    return UserAddressModel(
      addId: json['add_id'] ?? 0,
      labelAs: json['label_as'] ?? "",
      fullAddress: json['full_address'] ?? "",
      street: json['street'] ?? "",
      pinCode: json['pin_code'] ?? "",
      apartmentNo: json['apartment_no'] ?? "",
      buildingNo: json['building_no'] ?? "",
      userId: json['user_id'] ?? 0,
    );
  }
}
