class PlaceOrderAddressModel {
  int? id;
  int? userId;
  String? landMark;
  String? state;
  String? pinCode;
  String? district;
  String? mobileNumber;
  String? fullAddress;

  PlaceOrderAddressModel(
      this.id,
      this.userId,
      this.landMark,
      this.state,
      this.pinCode,
      this.district,
      this.mobileNumber,
      this.fullAddress,
      );


  factory PlaceOrderAddressModel.fromJson(Map<String, dynamic> data) {
    return PlaceOrderAddressModel(
      data["id"],
      data["user_id"],
      data["land_mark"],
      data["state"],
      data["pin_code"],
      data["district"],
      data["mobile_number"],
      data["full_address"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "land_mark": landMark,
      "state": state,
      "pin_code": pinCode,
      "district": district,
      "mobile_number": mobileNumber,
      "full_address": fullAddress,
    };
  }
}
