import 'package:flutter/cupertino.dart';
import 'package:zaykazone/api/restaurant_details_api.dart';
import 'package:zaykazone/model/users/restaurant_details_modal.dart';

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
