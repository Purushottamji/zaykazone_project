import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/model/FavouriteModel/FavouriteModel.dart';


class ApiHelperClass {
  static const String baseUrl = "http://192.168.31.13:3000/add-favourite";


  static Future<List<FavouriteModel>> getFavourites(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/favourites/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => FavouriteModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load favourites");
    }
  }


  static Future<bool> addFavourite(int userId, int resId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-favourite'),
      body: jsonEncode({"id": userId, "res_id": resId}),
    );

    return response.statusCode == 200;
  }


  static Future<bool> deleteFavourite(int fevoId) async {
    final response = await http.delete(Uri.parse('$baseUrl/favourite/$fevoId'));
    return response.statusCode == 200;
  }
}