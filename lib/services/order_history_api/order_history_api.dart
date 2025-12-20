import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:zaykazone/model/order_history_modal/order_history_modal.dart';
class OrderHistoryApi {
 static Future<List<OrderHistoryModal>?> getOrderHistory(int userId)async{
    var response=await http.get(Uri.parse("https://zaykazone-project-api.onrender.com/orderhistory/order/$userId"));
    if(response.statusCode==200){
    List<dynamic> resBody=jsonDecode(response.body);
    return resBody.map((e) => OrderHistoryModal.orderModal(e)).toList();


    }
    return null;

  }


}