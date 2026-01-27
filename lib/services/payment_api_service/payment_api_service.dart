import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaykazone/utils/constants/constants.dart';

import '../../model/payment_model/payment_model.dart';

class PaymentApi {
  static Future<List<PaymentModal>> getPayment(int userId) async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/payment/$userId"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => PaymentModal.fromJson(e)).toList();
    }
    return [];
  }

  static Future<PaymentModal?> addPayment(
      int userId, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(
          "${AppConstants.baseUrl}/payment/addPayment/$userId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return PaymentModal.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<bool> deletePayment(int paymentId) async {
    final response = await http.delete(
      Uri.parse(
        "${AppConstants.baseUrl}/payment/deletePayment/$paymentId",
      ),
    );

    return response.statusCode == 200;
  }
}
