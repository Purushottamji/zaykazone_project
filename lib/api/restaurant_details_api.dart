import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/model/users/restaurant_details_modal.dart';

class RestaurantDetailsApi{
  static Future<List<RestaurantDetailsModal>?> getRestaurantDetailsApi() async {
    var response= await http.get(Uri.parse("http://10.115.48.10:3000/restaurant"));
    if(response.statusCode==200){
      var reyBody=response.body;
      List<dynamic> json=jsonDecode(reyBody);
      var convertToMode=json.map((e) => RestaurantDetailsModal.getModal(e),).toList();
      return convertToMode;
    }
    return null;
  }
}
