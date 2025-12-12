import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_whatsapp/from_whatsapp_login.dart';
import 'package:zaykazone/utils/constants/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserType();
  }

 Future<String?> getUserType() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var userType=prefs.getString("user_type");
    print("This is user Type:- $userType");
    return userType;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    final whatsappP = Provider.of<WhatsappLoginProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final imageUrl=provider.userData?["user_pic"]?? "";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xffFF620D),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.03),
            child: Form(
              key: provider.pFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: w * 0.18,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: provider.image != null
                            ? FileImage(provider.image!) as ImageProvider
                            : (imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: provider.pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffFF620D),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.05),
                  buildTextField(
                    icon: CupertinoIcons.person,
                    label: "Enter your name",
                    controller: provider.pNameController,
                  ),
                  SizedBox(height: h * 0.02),
                  buildTextField(
                    icon: Icons.email_outlined,
                    label: "Enter your email",
                    controller: provider.pEmailController,
                  ),
                  SizedBox(height: h * 0.02),
                  buildTextField(
                    icon: Icons.phone_enabled_outlined,
                    label: "Enter your phone number",
                    controller: provider.pMobileController,
                  ),
                  SizedBox(height: h * 0.02),
                  buildTextField(
                    icon: Icons.info_outline,
                    label: "Enter your bio",
                    controller: provider.pBioController,
                    maxLines: 3,
                  ),
                  SizedBox(height: h * 0.04),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF620D),
                        padding: EdgeInsets.symmetric(vertical: h * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async{
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        var userType=prefs.getString("user_type") ?? "whatsapp";
                        if(userType=="email"){
                          await provider.updateProfile(context);
                        }else {
                          await whatsappP.updateUser(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xffFF620D)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
