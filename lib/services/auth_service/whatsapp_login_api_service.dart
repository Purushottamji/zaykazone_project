import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utils/constants/constants.dart';

class WhatsappLoginApiService {
  static String sendOtpUrl = "${AppConstants.baseUrl}/otp/send-otp";
  static String verifyOtpUrl = "${AppConstants.baseUrl}/otp/verify-otp";
  static String updateUserUrl = "${AppConstants.baseUrl}/otp/update-profile";

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

  static Future<Map<String, dynamic>?> updateUser({
    required String token,
    String? name,
    String? email,
    String? bio,
    File? image,
  }) async {
    try {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse(updateUserUrl),
      );

      // jwt token required
      request.headers['Authorization'] = "Bearer $token";

      if (name != null) request.fields['name'] = name;
      if (email != null) request.fields['email'] = email;
      if (bio != null) request.fields['user_bio'] = bio;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "user_pic",
            image.path,
          ),
        );
      }

      var response = await request.send();
      var body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(body);
      } else {
        return {"success": false, "body": body};
      }
    } catch (e) {
      print("Update User Error: $e");
      return null;
    }
  }
}
