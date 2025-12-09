import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zaykazone/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class FromWhatsappLogin with ChangeNotifier {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool get loading => _loading;

  // OTP controllers
  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  bool isResendAvailable = false;
  int timerSeconds = 30;

  // APIs
  String sendOtpUrl = "${AppConstants.baseUrl}/otp/send-otp";
  String verifyOtpUrl = "${AppConstants.baseUrl}/otp/verify-otp";

  // Loading state
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //send otp
  Future<bool> sendOtp(String phone) async {
    setLoading(true);

    final url = Uri.parse(sendOtpUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    setLoading(false);

    return response.statusCode == 200;
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    setLoading(true);

    final url = Uri.parse(verifyOtpUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone, "otp": otp}),
    );

    setLoading(false);

    return response.statusCode == 200;
  }

  void startTimer() {
    timerSeconds = 30;
    isResendAvailable = false;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (timerSeconds == 0) {
        isResendAvailable = true;
        notifyListeners();
        return false;
      }

      timerSeconds--;
      notifyListeners();
      return true;
    });
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
  }

}
