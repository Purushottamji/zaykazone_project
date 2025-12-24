import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/services/auth_service/whatsapp_login_api_service.dart';

class WhatsappLoginProvider with ChangeNotifier {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());

  bool _loading = false;
  bool get loading => _loading;

  bool isResendAvailable = false;
  int timerSeconds = 30;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> sendOtp(String phone) async {
    setLoading(true);
    bool success = await WhatsappLoginApiService.sendOtp(phone);
    setLoading(false);
    return success;
  }

  Future<bool> resendOtp(String phone) async {
    return await WhatsappLoginApiService.sendOtp(phone);
  }

  Future<bool> verifyOtp(String phone) async {
    String otp = getOtp();
    if (otp.length != 6) return false;

    setLoading(true);
    Map<String, dynamic>? data =
    await WhatsappLoginApiService.verifyOtp(phone, otp);
    setLoading(false);

    if (data == null) return false;

    await saveUserSession(data);
    return true;
  }

  Future<bool> isLoggedIn() async {
    const storage = FlutterSecureStorage();
    return storage.containsKey(key: "auth_token");
  }

  Future<void> saveUserSession(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_type", "whatsapp");

    const storage = FlutterSecureStorage();
    await storage.write(key: "auth_token", value: data['token']);
    await storage.write(key: "refresh_token", value: data["refreshToken"]);
    await storage.write(key: "user", value: jsonEncode(data['user']));
  }

  Future<Map<String, dynamic>?> updateUser({
    required LoginProvider loginProvider,
  }) async {
    setLoading(true);

    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "auth_token");

    if (token == null) {
      setLoading(false);
      return {"success": false, "message": "User not logged in"};
    }

    final result = await WhatsappLoginApiService.updateUser(
      token: token,
      name: loginProvider.pNameController.text,
      email: loginProvider.pEmailController.text,
      image: loginProvider.imageFile,
      bio: loginProvider.pBioController.text,
    );

    setLoading(false);


    if (result != null && result["user"] != null) {
      await storage.write(
        key: "user",
        value: jsonEncode(result["user"]),
      );

      loginProvider.userData = result["user"];
      loginProvider.notifyListeners();
    }

    return result;
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
    return otpControllers.map((c) => c.text).join();
  }
}
