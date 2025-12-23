import 'package:flutter/cupertino.dart';
import '../../model/place_order_address_model/place_order_address_model.dart';
import '../../services/place_order_address_api/place_order_address_api.dart';

class PlaceOrderAddressProvider with ChangeNotifier {
  TextEditingController landMarkController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  List<PlaceOrderAddressModel> addressList = [];

  Future<void> addressGet(BuildContext context) async {
    var response = await PlaceOrderAddressApi.getAddress(context);
    if (response != null) {
      addressList = response;
      print(addressList);
      notifyListeners();
    }
  }

  Future<bool> addAddress(BuildContext context) async {
    Map<String, dynamic> data = {
      "land_mark": landMarkController.text.trim(),
      "state": stateController.text.trim(),
      "pin_code": pinCodeController.text.trim(),
      "district": districtController.text.trim(),
      "mobile_number": mobileNumberController.text.trim(),
      "full_address": fullAddressController.text.trim(),
    };

    final response =
    await PlaceOrderAddressApi.addAddress(data, context);

    if (response != null) {
      await addressGet(context);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> updateAddress(BuildContext context,int id) async {
    Map<String, dynamic> data = {
      "land_mark": landMarkController.text,
      "state": stateController.text,
      "pin_code": pinCodeController.text,
      "district": districtController.text,
      "mobile_number": mobileNumberController.text,
      "full_address": fullAddressController.text,
    };

    var response = await PlaceOrderAddressApi.updateAddress(data, id: id);
    if (response != null) {
      await addressGet(context);
      notifyListeners();
    }}

  void setTextControllers(PlaceOrderAddressModel item){

    landMarkController.text = item.landMark;
    stateController.text = item.state;
    pinCodeController.text = item.pinCode;
    districtController.text = item.district;
    mobileNumberController.text = item.mobileNumber;
    fullAddressController.text = item.fullAddress;
  }
}
