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

    var response = await http.get(
      Uri.parse(
          "https://zaykazone-project-api.onrender.com/place/order/$userId"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => PlaceOrderAddressModel.fromJson(e)).toList();
    }

    return null;
  }

  // static Future<UpdatedData?> updateAddress(Map<String, dynamic> data,
  //     {required int id}) async {
  //   var response = await http.patch(
  //     Uri.parse(
  //         "https://zaykazone-project-api.onrender.com/place/patchorder/$id"),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode(data),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var body = jsonDecode(response.body);
  //     return UpdatedData.fromJson(body["updated_data"]);
  //   }
  //
  //   return null;
  // }
  // static Future<PlaceOrderAddressModel?> addAddress(
  //     BuildContext context,
  //     Map<String, dynamic> data,
  //     ) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("https://zaykazone-project-api.onrender.com/place/addorder"),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(data),
  //     );
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //
  //       // model convert
  //       return PlaceOrderAddressModel.fromJson(body);
  //     } else {
  //       debugPrint("Failed: ${response.body}");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //     return null;
  //   }
  // }

  static Future<PlaceOrderAddressModel?> addAddress(
      BuildContext context,
      Map<String, dynamic> data,
      ) async {
    try {
      final userId = storeUserId(context); // 👈 user id

      data["user_id"] = userId;

      final response = await http.post(
        Uri.parse("https://zaykazone-project-api.onrender.com/place/addorder"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return PlaceOrderAddressModel.fromJson(body);
      } else {
        debugPrint("Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }


}
