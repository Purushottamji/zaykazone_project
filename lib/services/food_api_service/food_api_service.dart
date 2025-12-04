import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/food_model/food_model.dart';
import '../../utils/constants/constants.dart';

class FoodApiService {
  static Future<List<FoodModel>?> fetchFood() async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/food"),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List list = body["message"] ?? [];
      return list.map((e) => FoodModel.fromJson(e)).toList();
    }
    return null;
  }
}