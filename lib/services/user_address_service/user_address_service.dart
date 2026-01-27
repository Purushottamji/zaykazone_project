import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/model/user_address_model/user_address_model.dart';
import 'package:zaykazone/utils/constants/constants.dart';

class UserAddressService {
  static int? userId;

  static int storeUserId(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);

    // Correct keys based on your real login JSON
    userId = provider.userData?["id"] ?? provider.userData?["user_id"];

    if (userId == null) {
      print(" User ID still null. LoginProvider not loaded yet.");
    }

    return userId ?? 0;
  }


  static Future<List<UserAddressModel>> getUserAddress() async {
    if (userId == null) {
      print("User ID not set. Call storeUserId(context) first.");
      return [];
    }

    try {
      final url = Uri.parse("${AppConstants.baseUrl}/address/$userId");
      final response = await http.get(url);

      print(" Response Status: ${response.statusCode}");
      print(" Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded["data"] is List) {
          return (decoded["data"] as List)
              .map((item) => UserAddressModel.fromJson(item))
              .toList();
        } else {
          print(" JSON format mismatch! Expected: { data: [] }");
        }
      } else {
        print(" Failed to fetch addresses: ${response.statusCode}");
      }
    } catch (e) {
      print(" Error in getUserAddress: $e");
    }

    return [];
  }


  static Future<bool> addAddress(Map<String, dynamic> body) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/address/add");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("📩 ADD Address Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print(" Error in addAddress: $e");
      return false;
    }
  }

  static Future<bool> updateAddress(int addId, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/address/$addId");

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("📩 UPDATE Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating address: $e");
      return false;
    }
  }

  static Future<bool> deleteAddress(int addId) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/address/$addId");

      final response = await http.delete(url);

      print("🗑 Delete Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print(" Error deleting address: $e");
      return false;
    }
  }

}
