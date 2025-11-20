import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {

  static Future<bool> sendOtp(String phone) async {
    final url = Uri.parse("http://YOUR_IP:3000/send-otp");

    final res = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone})
    );

    if (res.statusCode == 200) {
      print(res.body);
      return true;
    } else {
      return false;
    }
  }
}
