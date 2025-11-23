import 'dart:convert';
import 'package:http/http.dart' as http;

class Restaurant {


  static Future<List<dynamic>> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse("https://dummyjson.com/products"));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        return jsonData["products"]; 
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
