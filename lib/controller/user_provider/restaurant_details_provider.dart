import 'package:flutter/cupertino.dart';
import 'package:zaykazone/model/users/restaurant_details_modal.dart';

import '../../services/restaurant_detail_api/restaurant_details_api.dart';

class RestaurantDetailsProvider with ChangeNotifier {
  List<RestaurantDetailsModal> listProduct = [];

  Future<void> getProduct() async {
    var response = await RestaurantDetailsApi.getRestaurantDetailsApi();
    if (response != null) {
      listProduct = response;
      notifyListeners();
    }
  }
}
