import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/model/users/restaurant_details_modal.dart';
import 'package:zaykazone/utils/constants/constants.dart';

class RestaurantDetailsApi {
  static Future<List<RestaurantDetailsModal>?> getRestaurantDetailsApi() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/restaurant"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((e) => RestaurantDetailsModal.getModal(e))
          .toList();
    }
    return null;
  }
}
