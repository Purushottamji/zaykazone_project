import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/services/auth_service/auth_api_service.dart';
import 'package:zaykazone/services/auth_service/profile_update_api_service.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../../../../view/screens/edit_profile/edit_profile.dart';
import '../../../../view/screens/login_page/login_screen.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passController = TextEditingController();


  final pNameController = TextEditingController();
  final pEmailController = TextEditingController();
  final pMobileController = TextEditingController();
  final pBioController = TextEditingController();
  final pFormKey = GlobalKey<FormState>();

  File? image ;
  final picker = ImagePicker();

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      image = File(picked.path);
      notifyListeners();
    }
  }


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

  void setOption(String? value) {
    _selectedOption = value;
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final storage= FlutterSecureStorage();
    await storage.write(key: "auth_token", value: token);

  }

  Future<void> logout(BuildContext context) async {
    final storage= FlutterSecureStorage();
    await storage.deleteAll();


    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
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


  // Future<Map<String, dynamic>?> getUser() async {
  //   final storage= FlutterSecureStorage();
  //   String? userJson = await storage.read(key: "user");
  //
  //   if (userJson == null) return null;
  //
  //   userData = jsonDecode(userJson);
  //   notifyListeners();
  //   return userData;
  // }

  editProfile(BuildContext context) async {
    await getUser();

    pNameController.text = userData?["name"] ?? "";
    pEmailController.text = userData?["email"] ?? "";
    pMobileController.text = userData?["mobile"] ?? "";
    pBioController.text = userData?["bio"] ?? "";
    image = null;

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
      image: image,
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
    image=null;
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



}
