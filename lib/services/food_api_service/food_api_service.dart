import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/utils/constants/constants.dart';
import '../../model/food_model/food_model.dart';

class FoodApiService {
  static const String baseUrl =
      "${AppConstants.baseUrl}/food";
 static Future<List<FoodModel>?> fetchFood() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => FoodModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load food data");
    }
  }
}
