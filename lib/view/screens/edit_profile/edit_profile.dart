import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_whatsapp/from_whatsapp_login.dart';

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

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_type");
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    final whatsappP = context.watch<WhatsappLoginProvider>();

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final imageUrl = provider.userData?["user_pic"] ?? "";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _glassAppBar(context),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06, vertical: h * 0.03),
                child: Form(
                  key: provider.pFormKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 10, sigmaY: 10),
                              child: CircleAvatar(
                                radius: w * 0.18,
                                backgroundColor:
                                Colors.white.withOpacity(0.25),
                                backgroundImage: provider.imageFile != null
                                    ? FileImage(provider.imageFile!)
                                    : (imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : null) as ImageProvider?,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: (){
                                provider.pickImage(ImageSource.gallery);
                              },
                              child: _glassIcon(Icons.edit),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: h * 0.05),

                      _glassField(
                        icon: CupertinoIcons.person,
                        label: "Name",
                        controller: provider.pNameController,
                      ),
                      SizedBox(height: h * 0.02),

                      _glassField(
                        icon: Icons.email_outlined,
                        label: "Email",
                        controller: provider.pEmailController,
                      ),
                      SizedBox(height: h * 0.02),

                      _glassField(
                        icon: Icons.phone_enabled_outlined,
                        label: "Phone",
                        controller: provider.pMobileController,
                      ),
                      SizedBox(height: h * 0.02),

                      _glassField(
                        icon: Icons.info_outline,
                        label: "Bio",
                        controller: provider.pBioController,
                        maxLines: 3,
                      ),

                      SizedBox(height: h * 0.04),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffFF620D),
                            padding: EdgeInsets.symmetric(
                                vertical: h * 0.02),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              final userType = prefs.getString("user_type") ?? "whatsapp";

                              final loginProvider =
                              context.read<LoginProvider>(); // 👈 CORRECT
                              final whatsappProvider =
                              context.read<WhatsappLoginProvider>();

                              if (userType == "email") {
                                await loginProvider.updateProfile(context);
                              } else {
                                await whatsappProvider.updateUser(
                                  loginProvider: loginProvider,
                                );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassAppBar(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,),
          decoration: BoxDecoration(
            color: Color(0xffFF620D).withOpacity(0.60),
            border: Border(
              bottom:
              BorderSide(color: Colors.white.withOpacity(0.25)),
            ),
          ),
          child: Row(
            children: [
              _glassBack(() => Navigator.pop(context)),
              const SizedBox(width: 16),
              const Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon:
            Icon(icon, color: const Color(0xffFF620D)),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white.withOpacity(0.4),
          child: Icon(icon,
              color: const Color(0xffffffff), size: 20),
        ),
      ),
    );
  }

  Widget _glassBack(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _glassIcon(Icons.arrow_back_ios_new),
    );
  }
}
