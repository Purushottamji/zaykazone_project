import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../../model/place_order_address_model/place_order_address_model.dart';

class PlaceOrderAddressApi {
  static int storeId = 0;

  static int storeUserId(BuildContext context) {
    var data = Provider.of<LoginProvider>(context, listen: false).userData;

    if (data != null) {
      storeId = int.parse(data["id"].toString());
    }
    return storeId;
  }

  static Future<List<PlaceOrderAddressModel>?> getAddress(
      BuildContext context) async {
    int userId = storeUserId(context);

    print("User ID passed: $userId");

    var response = await http.get(
      Uri.parse(
          "https://zaykazone-project-api.onrender.com/place/order/$userId"),
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => PlaceOrderAddressModel.fromJson(e)).toList();
    }

    return null;
  }
}




