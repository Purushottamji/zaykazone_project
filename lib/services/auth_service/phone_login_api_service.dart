import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/constants/constants.dart';

class PhoneLoginApiService {
  static String sendOtpUrl = "${AppConstants.baseUrl}/phone/send-otp";
  static String verifyOtpUrl = "${AppConstants.baseUrl}/phone/verify-otp";

  static Future<bool> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse(sendOtpUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );
    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>?> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse(verifyOtpUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone, "otp": otp}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

}
