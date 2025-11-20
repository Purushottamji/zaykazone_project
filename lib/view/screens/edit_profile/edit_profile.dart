import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaykazone/view/screens/address/address_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFF620D),
          leading: const Icon(CupertinoIcons.back),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: w * 0.18,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage("assets/images/img_1.png")
                      as ImageProvider,
                    ),

                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffFF620D),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.edit, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.05),

                buildTextField(
                  icon: CupertinoIcons.person,
                  label: "Enter your name",
                ),

                SizedBox(height: h * 0.02),

                buildTextField(
                  icon: Icons.email_outlined,
                  label: "Enter your email",
                ),

                SizedBox(height: h * 0.02),

                buildTextField(
                  icon: Icons.phone_enabled_outlined,
                  label: "Enter your phone number",
                ),

                SizedBox(height: h * 0.02),

                buildTextField(
                  icon: Icons.info_outline,
                  label: "Enter your bio",
                  maxLines: 3,
                ),

                SizedBox(height: h * 0.04),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF620D),
                      padding: EdgeInsets.symmetric(vertical: h * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddressScreen()),
                      );
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
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String label,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xffFF620D)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
