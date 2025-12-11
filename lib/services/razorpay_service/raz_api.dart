// import 'dart:convert';
// import 'package:http/http.dart' as http;
// class ApiHelper {
//   static Future<String?> CreateId(int totalAmount)async{
//     String basicAuth = 'Basic ' + base64.encode(utf8.encode('rzp_test_RD0BiIvkAPO6jt:rPzFNq6hJlZpoqrWJNmXheLV'));
//     var requestBody= jsonEncode({
//
//       "amount": totalAmount * 100,
//       "amount_due": 1000,
//       "amount_paid": 0,
//       "attempts": 0,
//       "created_at": 1756883333,
//       "currency": "INR",
//       "entity": "order",
//       "id": "order_RD2bX8rzLzfN9C",
//       "notes": {
//         "notes_key_1": "Tea, Earl Grey, Hot",
//         "notes_key_2": "Tea, Earl Grey… decaf."
//       },
//     });
//     var responce=await http.post(Uri.parse("https://api.razorpay_service.com/v1/orders"),body: requestBody,headers: {"authorization":basicAuth});
//     if(responce.statusCode==200){
//       var json=jsonDecode(responce.body);
//       var id= json["id"];
//       return id;
//     }
//     return "";
//   }
// }
//
//



import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<String?> CreateId(int totalAmount) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            'rzp_test_RD0BiIvkAPO6jt:rPzFNq6hJlZpoqrWJNmXheLV'));

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

