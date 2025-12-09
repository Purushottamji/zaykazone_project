import 'package:flutter/material.dart';
import 'package:zaykazone/model/user_address_model/user_address_model.dart';
import 'package:zaykazone/services/user_address_service/user_address_service.dart';

class UserAddressProvider with ChangeNotifier {
  final addressController = TextEditingController();
  final streetController = TextEditingController();
  final flatNoController = TextEditingController();
  final buildingNoController = TextEditingController();
  final pinController = TextEditingController();

  List<UserAddressModel> userAddress = [];

  bool isLoading = false;

  Future<void> fetchUserAddress() async {
    print("🔍 Debug: fetchUserAddress() called");
    print("🔍 Debug: Current userId = ${UserAddressService.userId}");
    if (UserAddressService.userId == null) {
      print("❌ Cannot fetch address. User ID is null.");
      return;
    }

    isLoading = true;
    notifyListeners();

    userAddress = await UserAddressService.getUserAddress();

    isLoading = false;
    notifyListeners();
  }

  String getLabelFromIndex(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Work";
      case 2:
        return "Other";
      default:
        return "Home";
    }
  }

  int getIndexFromLabel(String label) {
    switch (label) {
      case "Home":
        return 0;
      case "Work":
        return 1;
      case "Other":
        return 2;
      default:
        return 0;
    }
  }

  void setAddressData(UserAddressModel model) {
    addressController.text = model.fullAddress;
    streetController.text = model.street;
    pinController.text = model.pinCode;
    flatNoController.text = model.apartmentNo;
    buildingNoController.text = model.buildingNo;
  }

  Future<bool> saveAddress(String labelAs) async {
    final body = {
      "label_as": labelAs,
      "full_address": addressController.text.trim(),
      "street": streetController.text.trim(),
      "pin_code": pinController.text.trim(),
      "apartment_no": flatNoController.text.trim(),
      "building_no": buildingNoController.text.trim(),
      "user_id": UserAddressService.userId
    };

    bool success = await UserAddressService.addAddress(body);

    if (success) {
      await fetchUserAddress();
    }

    return success;
  }

  Future<bool> updateAddress(int addId, String labelAs) async {
    final body = {
      "label_as": labelAs,
      "full_address": addressController.text.trim(),
      "street": streetController.text.trim(),
      "pin_code": pinController.text.trim(),
      "apartment_no": flatNoController.text.trim(),
      "building_no": buildingNoController.text.trim(),
    };

    bool success = await UserAddressService.updateAddress(addId, body);

    if (success) fetchUserAddress();

    return success;
  }

  Future<bool> removeAddress(int addId) async {
    bool success = await UserAddressService.deleteAddress(addId);

    if (success) fetchUserAddress();

    return success;
  }


  @override
  void dispose() {
    addressController.dispose();
    streetController.dispose();
    flatNoController.dispose();
    buildingNoController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
