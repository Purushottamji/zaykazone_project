import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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

  File? _image;
  File? get image => _image;

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path); // Real file path
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");

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

    if (data != null && data["token"] != null) {
      await _saveToken(data["token"]);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(data["user"]));

      await getUser();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Email or Password")));
    }
  }


  Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("user");

    if (userJson == null) return null;

    userData = jsonDecode(userJson);
    notifyListeners();
    return userData;
  }

  editProfile(BuildContext context) async {
    await getUser();

    pNameController.text = userData?["name"] ?? "";
    pEmailController.text = userData?["email"] ?? "";
    pMobileController.text = userData?["mobile"] ?? "";
    pBioController.text = userData?["bio"] ?? "";

    _image = null;

    notifyListeners();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }


  Future<void> updateProfile(BuildContext context) async {
    if (!pFormKey.currentState!.validate()) return;

    String userId = userData!["id"].toString();

    File? newImageToUpload;

    if (_image != null && _image!.path.contains("/")) {
      newImageToUpload = _image;
    }

    var result = await ProfileUpdateApiService.updateUser(
      id: userId,
      name: pNameController.text.trim(),
      email: pEmailController.text.trim(),
      mobile: pMobileController.text.trim(),
      bio: pBioController.text.trim(),
      image: newImageToUpload,
    );

    if (result != null && result["user"] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("user", jsonEncode(result["user"]));

      userData = result["user"];
      notifyListeners();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile updated successfully")));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update failed")));
    }
  }
}
