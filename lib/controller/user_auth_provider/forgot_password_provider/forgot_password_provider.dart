import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zaykazone/utils/constants/constants.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool loading = false;
  String email = "";

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<bool> sendOtp(String userEmail) async {
    setLoading(true);
    email = userEmail;

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/forgot-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": userEmail}),
      );

      setLoading(false);
      return response.statusCode == 200;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    setLoading(true);

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      setLoading(false);
      return response.statusCode == 200;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword) async {
    setLoading(true);

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/reset-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "newPassword": newPassword,
        }),
      );

      setLoading(false);
      return response.statusCode == 200;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }
}
