import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/auth_service/phone_login_api_service.dart';

class PhoneAuthProvider with ChangeNotifier {

  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool isResendAvailable = false;
  int timerSeconds = 60;
  Timer? _timer;

  String getOtp() {
    return otpControllers.map((c) => c.text).join();
  }

  Future<bool> sendOtp(String phone) async {
    setLoading(true);

    final success = await PhoneLoginApiService.sendOtp(phone);

    setLoading(false);

    if (success) {
      startTimer();
    }

    return success;
  }

  Future<bool> resendOtp(String phone) async {
    return await PhoneLoginApiService.sendOtp(phone);
  }

  Future<bool> verifyOtp(String phone) async {
    final otp = getOtp();
    if (otp.length != 6) return false;

    setLoading(true);

    final data = await PhoneLoginApiService.verifyOtp(phone, otp);

    setLoading(false);

    if (data == null) return false;

    await saveUserSession(data);
    return true;
  }

  Future<void> saveUserSession(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_type", "phone");

    const storage = FlutterSecureStorage();
    await storage.write(key: "auth_token", value: data["token"]);
    await storage.write(
        key: "refresh_token", value: data["refreshToken"]);
    await storage.write(
        key: "user", value: jsonEncode(data["user"]));
  }

  Future<bool> isLoggedIn() async {
    const storage = FlutterSecureStorage();
    return storage.containsKey(key: "auth_token");
  }

  void startTimer() {
    _timer?.cancel();
    timerSeconds = 60;
    isResendAvailable = false;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds == 0) {
        isResendAvailable = true;
        timer.cancel();
      } else {
        timerSeconds--;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }
}
