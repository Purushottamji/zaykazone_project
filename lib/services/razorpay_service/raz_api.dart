import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<String?> CreateId(int totalAmount) async {
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('rzp_test_RD0BiIvkAPO6jt:rPzFNq6hJlZpoqrWJNmXheLV'));

    var body = {
      "amount": totalAmount * 100, // amount in paise
      "currency": "INR",
      "receipt": "receipt_${DateTime.now().millisecondsSinceEpoch}",
    };

    var response = await http.post(
      Uri.parse("https://api.razorpay.com/v1/orders"),
      headers: {
        "Content-Type": "application/json",
        "authorization": basicAuth,
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json["id"]; // Razorpay order_id
    } else {
      print("Order failed: ${response.body}");
      return null;
    }
  }
}
