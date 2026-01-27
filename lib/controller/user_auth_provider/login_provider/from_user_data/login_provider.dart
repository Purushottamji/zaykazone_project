import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/services/auth_service/auth_api_service.dart';
import 'package:zaykazone/services/auth_service/profile_update_api_service.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../view/screens/edit_profile/edit_profile.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passController = TextEditingController();


  final pNameController = TextEditingController();
  final pEmailController = TextEditingController();
  final pMobileController = TextEditingController();
  final pBioController = TextEditingController();
  final pFormKey = GlobalKey<FormState>();

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  bool loading = false;
  bool showPass = true;

  String? token;
  String? _selectedOption;
  Map<String, dynamic>? userData;

  String? get selectedOption => _selectedOption;

  final formKey = GlobalKey<FormState>();

  togglePass() {
    showPass = !showPass;
    notifyListeners();
  }

  Future pickImage(ImageSource source) async {
    final XFile? picked = await picker.pickImage(source: source);

    if (picked != null) {
      imageFile = File(picked.path);
      notifyListeners();
    }
  }

  void setOption(String? value) {
    _selectedOption = value;
    notifyListeners();
  }


  Future<bool> logout() async {
    loading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "auth_token");
      final refreshToken = await storage.read(key: "refresh_token");

      try {
        await http.post(
          Uri.parse("${AppConstants.baseUrl}/auth/logout"),
          headers: {
            "Content-Type": "application/json",
            if (token != null) "Authorization": "Bearer $token",
          },
          body: jsonEncode({"refreshToken": refreshToken}),
        );
      } catch (_) {
        // ignore api failure
      }

      await storage.deleteAll();
      await prefs.remove("user_type");

      loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return true;
    }
  }


  Future<void> loginUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    notifyListeners();

    var data = await ApiService.loginApi(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );

    loading = false;
    notifyListeners();

    if (data != null && data["accessToken"] != null) {
      final storage = FlutterSecureStorage();
      final prefs = await SharedPreferences.getInstance();

      await storage.write(
        key: "auth_token",
        value: data["accessToken"],
      );

      await storage.write(
        key: "refresh_token",
        value: data["refreshToken"],
      );

      await storage.write(
        key: "user",
        value: jsonEncode(data["user"]),
      );

      prefs.setString("user_type", "email");

      await getUser();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      emailController.clear();
      passController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BottomNavigationBarScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid Email or Password")),
      );
    }
  }

  editProfile(BuildContext context) async {
    await getUser();

    pNameController.text = userData?["name"] ?? "";
    pEmailController.text = userData?["email"] ?? "";
    pMobileController.text = userData?["mobile"] ?? "";
    pBioController.text = userData?["bio"] ?? "";
    imageFile = null;

    notifyListeners();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }


  Future<void> updateProfile(BuildContext context) async {
    if (!pFormKey.currentState!.validate()) return;

    String userId = userData!["id"].toString();

    var result = await ProfileUpdateApiService.updateUser(
      id: userId,
      name: pNameController.text.trim() ?? "",
      email: pEmailController.text.trim() ?? "",
      mobile: pMobileController.text.trim() ?? "",
      bio: pBioController.text.trim() ?? "",
      image: imageFile,
    );

    if (result != null && result["user"] != null) {
      final storage=FlutterSecureStorage();
      await storage.write(key: "user", value: jsonEncode(result["user"]));

      userData = result["user"];
      notifyListeners();
      clearField();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile updated successfully")));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update failed")));
    }
  }

  clearField(){
    pNameController.clear();
    pEmailController.clear();
    pMobileController.clear();
    pBioController.clear();
    imageFile=null;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUser() async {
    final storage= FlutterSecureStorage();
    String? userJson = await storage.read(key: "user");

    if (userJson == null) return null;

    userData = jsonDecode(userJson);
    notifyListeners();
    return userData;
  }

  Future<String?> getUserIdFromStorage() async {
    final storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: "user");

    if (userJson == null) return null;

    final user = jsonDecode(userJson);
    print("user_id : ${user['id'].toString()}");
    return user["id"]?.toString();
  }


  Future<bool> deleteAccount() async {
    loading=true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final storage=FlutterSecureStorage();

      final token = await storage.read(key: "auth_token");
      final response = await http.delete(
        Uri.parse("${AppConstants.baseUrl}/users/delete/${userData!["id"]}"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
       await storage.deleteAll();
       await prefs.clear();
        loading=false;
        notifyListeners();
        return true;
      }

      loading=false;
      notifyListeners();
      return false;
    } catch (e) {
      loading=false;
      notifyListeners();
      return false;
    }
  }


// Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token");
  //   if (token == null) return false;
  //
  //   // call a protected endpoint to validate (GET /user/me)
  //   final url = Uri.parse("${AppConstants.baseUrl}/user/me");
  //   final response = await http.get(url, headers: {"Authorization": "Bearer $token"});
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     // update stored user if returned
  //     if (data['user'] != null) {
  //       prefs.setString("user", jsonEncode(data['user']));
  //     }
  //     return true;
  //   }
  //
  //   // try refresh
  //   final refreshToken = prefs.getString("refreshToken");
  //   if (refreshToken == null) return false;
  //
  //   final r = await http.post(Uri.parse("${AppConstants.baseUrl}/auth/refresh"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({"refreshToken": refreshToken}),
  //   );
  //
  //   if (r.statusCode == 200) {
  //     final newToken = jsonDecode(r.body)['token'];
  //     await prefs.setString("token", newToken);
  //     return true;
  //   }
  //
  //   // else force logout locally
  //   await prefs.remove("token");
  //   await prefs.remove("refreshToken");
  //   await prefs.remove("user");
  //   return false;
  // }

}
