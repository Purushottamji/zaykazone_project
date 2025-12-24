import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

      request.headers['Authorization'] = "Bearer $token";

      if (name != null) request.fields['name'] = name;
      if (email != null) request.fields['email'] = email;
      if (bio != null) request.fields['user_bio'] = bio;

      if (image != null) {
        final ext = image.path.split('.').last.toLowerCase();
        final mime = ext == "png" ? "png" : "jpeg";

        request.files.add(
          await http.MultipartFile.fromPath(
            "user_pic",
            image.path,
            contentType: MediaType("image", mime),
          ),
        );
      }

      var response = await request.send();
      var body = await response.stream.bytesToString();

      // ✅ SUCCESS
      if (response.statusCode == 200) {
        return jsonDecode(body);
      }

      // 🔥 TOKEN EXPIRED → REFRESH & RETRY
      if (response.statusCode == 401) {
        final decoded = jsonDecode(body);

        if (decoded["code"] == "TOKEN_EXPIRED") {
          final newToken = await _refreshAccessToken();

          if (newToken != null) {
            return updateUser(
              token: newToken,
              name: name,
              email: email,
              bio: bio,
              image: image,
            );
          }
        }
      }

      return {"success": false, "message": body};
    } catch (e) {
      print("Update User Error: $e");
      return null;
    }
  }

  static Future<String?> _refreshAccessToken() async {
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: "refresh_token");

    if (refreshToken == null) return null;

    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: "auth_token", value: data["token"]);
      return data["token"];
    }

    return null;
  }


}
