// import 'dart:convert';
//
// import 'package:http/http.dart'as http;
//
// class OrderApi {
//   getOrder() async {
//     var response= await http.get(Uri.parse("https://zaykazone-project-api.onrender.com/order/42"));
//     if(response.statusCode==200){
//       var body=jsonDecode(response.body);
//
//     }
//
//   }
//
//
// }



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/services/place_order_address_api/place_order_address_api.dart';
import '../../model/order_modal/order_modal.dart';

class OrderApi {

 static Future<OrderModal?> getOrder() async {
    try {
      var response = await http.get(
        Uri.parse("https://zaykazone-project-api.onrender.com/order/${PlaceOrderAddressApi.storeId}"),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return OrderModal.fromJson(body);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}

