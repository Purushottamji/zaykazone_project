import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/utils/constants/constants.dart';
import '../../model/order_modal/order_modal.dart';

class OrderApi {

  /// GET ORDERS
  static Future<OrderModal?> getOrdersByUserId(int userId) async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/order/user/$userId"),
    );

    if (response.statusCode == 200) {
      return OrderModal.fromJson(jsonDecode(response.body));
    }
    return null;
  }


  static Future<bool> placeOrder(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/order/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 201;
  }

  static Future<bool> updateOrderStatus(int orderId, String status) async {
    final res = await http.put(
      Uri.parse("${AppConstants.baseUrl}/order/status/$orderId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": status}),
    );

    return res.statusCode == 200;
  }


  /// CANCEL ORDER
  static Future<bool> cancelOrder(int orderId) async {
    final response = await http.put(
      Uri.parse("${AppConstants.baseUrl}/order/cancel/$orderId"),
    );

    return response.statusCode == 200;
  }

}
