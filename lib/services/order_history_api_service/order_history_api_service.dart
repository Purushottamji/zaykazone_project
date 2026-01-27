import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:zaykazone/utils/constants/constants.dart';
import '../../model/order_history_model/order_history_model.dart';

class OrderHistoryApi {
  static Future<List<OrderHistoryModal>?> getOrderHistory(int userId)async{
    var response=await http.get(Uri.parse("${AppConstants.baseUrl}/orderhistory/order/$userId"));
    if(response.statusCode==200){
      List<dynamic> resBody=jsonDecode(response.body);
      return resBody.map((e) => OrderHistoryModal.orderModal(e)).toList();
    }
    return null;
  }
}