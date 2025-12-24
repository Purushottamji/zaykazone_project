import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaykazone/model/users/user_model.dart';

import '../../../services/auth_service/auth_api_service.dart';

class SignupProvider extends ChangeNotifier {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();



  // Password visibility
  bool showPass1 = true;
  bool showPass2 = true;

  // Profile image
  File? imageFile;

  // Toggle password visibility
  void togglePass1() {
    showPass1 = !showPass1;
    notifyListeners();
  }

  void togglePass2() {
    showPass2 = !showPass2;
    notifyListeners();
  }

  // Pick Image
  final ImagePicker picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final XFile? picked = await picker.pickImage(source: source);

    if (picked != null) {
      imageFile = File(picked.path);
      notifyListeners();
    }
  }



  Future<void> registerUser(BuildContext context) async {
    if(formKey.currentState!.validate()){
      if (passwordController.text.trim() !=
          cPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      bool ok = await ApiService.registerApi(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        imageFile: imageFile,
      );

      if (ok) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Signup Successful")));
        clearField();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Signup Failed")));
      }
    }

  }

  clearField(){
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    cPasswordController.clear();
    imageFile=null;
    notifyListeners();
  }
}
