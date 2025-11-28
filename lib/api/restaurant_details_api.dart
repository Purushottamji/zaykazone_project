import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/model/users/restaurant_details_modal.dart';

class RestaurantDetailsApi{
  static Future<List<RestaurantDetailsModal>?> getRestaurantDetailsApi() async {
    var response= await http.get(Uri.parse("https://zaykazone-project-api.onrender.com/restaurant"));
    if(response.statusCode==200){
      var reyBody=response.body;
      List<dynamic> json=jsonDecode(reyBody);
      var convertToMode=json.map((e) => RestaurantDetailsModal.getModal(e),).toList();
      return convertToMode;
    }
    return null;
  }
}
