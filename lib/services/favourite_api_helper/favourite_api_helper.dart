
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/utils/constants/constants.dart';
import '../../model/favourite_modal/favourite_modal.dart';

class ApiHelperClass {

  static Future<List<FavouriteModel>> getFavourites(int userId) async {
    final response =
    await http.get(Uri.parse('${AppConstants.baseUrl}/favourites/$userId'));

    final data = jsonDecode(response.body) ;
    return data.map((json) => FavouriteModel.fromJson(json)).toList();
  }

  static Future<bool> addFavourite(int userId, int resId) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/add-favourite'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": userId, "res_id": resId}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteFavourite(int fevoId) async {
    final response =
    await http.delete(Uri.parse('${AppConstants.baseUrl}/favourite/$fevoId'));
    return response.statusCode == 200;
  }
}
