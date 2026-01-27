
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zaykazone/utils/constants/constants.dart';

import '../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../../model/rating_model/rating_model.dart';

class RatingApi {
  static int storeId = 0;

  /// STORE USER ID
  static int storeUserId(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    storeId = provider.userData?["id"] ?? provider.userData?["user_id"] ?? 0;
    print("STORE USER ID = $storeId");
    return storeId;
  }

  /// GET ALL REVIEWS
  static Future<List<RatingModel>?> getRatingDetails() async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/rating"),
      );

      print("GET REVIEW RESPONSE → ${response.body}");

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => RatingModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Get Rating Error: $e");
    }
    return null;
  }

  /// ADD REVIEW
  static Future<RatingModel?> addReview({
    required int userId,
    required int resId,
    required String productName,
    required double rating,
    required String experience,
    required String userName
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/add_data/$userId"),
        body: {
          "res_id": resId.toString(),
          "product_name": productName,
          "rating": rating.toString(),
          "experience": experience,
          "user_name": userName
        },
      );

      print("ADD REVIEW RESPONSE → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RatingModel.fromJson(data);
      }
    } catch (e) {
      print("Add Rating Error: $e");
    }

    return null;
  }

  ///EDIT REVIEW


  static Future<RatingModel?> editReview({
    required int id,
     int? userId,
     int? resId,
    required String productName,
    required double rating,
    required String experience,

  }) async {
    try {
      final response = await http.put(
        Uri.parse("${AppConstants.baseUrl}/update_data/$id"),
        body: {
          "res_id": resId.toString(),
          "product_name": productName,
          "rating": rating.toString(),
          "experience": experience,
        },
      );

      print("ADD REVIEW RESPONSE → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RatingModel.fromJson(data);
      }
    } catch (e) {
      print("Add Rating Error: $e");
    }

    return null;
  }
  /// DELETE REVIEW
  static Future<bool> deleteRating(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("${AppConstants.baseUrl}/delete_data/$id"),
      );

      print("DELETE RESPONSE → ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Delete Rating Error: $e");
      return false;
    }
  }
}
