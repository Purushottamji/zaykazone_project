import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/constants.dart';

class PhoneAuthProvider extends ChangeNotifier {
  bool loading = false;

  final phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  bool isResendAvailable = false;
  int timerSeconds = 60;

  String getOtp() {
    return controllers.map((c) => c.text).join();
  }

  Future<bool> sendOtp(BuildContext context, String phone) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/phone/send-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
      }),
    );

    loading = false;
    notifyListeners();

    return response.statusCode == 200;
  }

  /// Verify OTP
  Future<bool> verifyOtp(String phone, String otp) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/phone/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
      }),
    );

    loading = false;
    notifyListeners();

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", data["token"]);
      //await prefs.setString("user", jsonEncode(data["user"]));

      return true;
    } else {
      return false;
    }
  }

  /// Timer
  void startTimer() {
    timerSeconds = 60;
    isResendAvailable = false;
    notifyListeners();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds == 0) {
        isResendAvailable = true;
        notifyListeners();
        timer.cancel();
      } else {
        timerSeconds--;
        notifyListeners();
      }
    });
  }
}
