import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/favourite_model/favourite_model.dart';
import '../../utils/token_helper/token_helper.dart';

class FavouriteFoodApi {
  static const String baseUrl =
      "https://zaykazone-project-api.onrender.com";

  static Future<int> addFavourite(int foodId) async {
    final token = await TokenHelper.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await http.post(
      Uri.parse("$baseUrl/favourites"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"food_id": foodId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['favourite_id'];
    } else {
      throw Exception(response.body);
    }
  }

  static Future<void> removeFavourite(int favId) async {
    final token = await TokenHelper.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await http.delete(
      Uri.parse("$baseUrl/favourites/$favId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  static Future<List<FavouriteFoodModel>> getFavouriteFood() async {
    final token = await TokenHelper.getToken();
    if (token == null) throw Exception("Token not found");

    final response = await http.get(
      Uri.parse("$baseUrl/favourites"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) => FavouriteFoodModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.body);
    }
  }
}