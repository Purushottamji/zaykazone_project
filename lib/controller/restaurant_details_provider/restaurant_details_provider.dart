import 'package:flutter/cupertino.dart';
import 'package:zaykazone/model/restaurant_details_model/restaurant_details_modal.dart';
import '../../services/restaurant_detail_api_service/restaurant_details_api.dart';

class RestaurantDetailsProvider with ChangeNotifier {
  List<RestaurantDetailsModal> allRestaurants = [];
  List<RestaurantDetailsModal> filteredRestaurants = [];

  Future<void> getProduct() async {
    var response = await RestaurantDetailsApi.getRestaurantDetailsApi();
    if (response != null) {
      allRestaurants = response;
      filteredRestaurants = List.from(allRestaurants);
      notifyListeners();
    }
  }

  void searchRestaurants(String query) {
    if (query.isEmpty) {
      filteredRestaurants = List.from(allRestaurants);
    } else {
      final lower = query.toLowerCase();

      filteredRestaurants = allRestaurants.where((r) {
        final name = r.name?.toLowerCase() ?? "";
        final address = r.address?.toLowerCase() ?? "";
        return name.contains(lower) || address.contains(lower);
      }).toList();
    }
    notifyListeners();
  }
}
