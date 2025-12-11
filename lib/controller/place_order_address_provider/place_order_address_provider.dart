import 'package:flutter/cupertino.dart';

import '../../model/place_order_address_model/place_order_address_model.dart';
import '../../services/place_order_address_api/place_order_address_api.dart';

class PlaceOrderAddressProvider with ChangeNotifier {
  List<PlaceOrderAddressModel> addressList = [];

  Future<void> addressGet(BuildContext context) async {
    var response = await PlaceOrderAddressApi.getAddress(context);

    print("response: $response");

    if (response != null) {
      addressList = response;
      notifyListeners();
    }
  }
}
