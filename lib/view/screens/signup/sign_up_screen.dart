import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? imageFile;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SizedBox(
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() => imageFile = File(picked.path));
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () async {
                final picked =
                await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() => imageFile = File(picked.path));
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),

        body: Container(
          color: Colors.black,
          child: ListView(
            children: [
              SizedBox(height: h * 0.04),

              /// Title
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: h * 0.01),

              /// Subtitle
              Center(
                child: Text(
                  "Please sign up to get started",
                  style: TextStyle(
                    fontSize: w * 0.04,
                    color: Colors.white70,
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              Container(
                height: h * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.03),

                      Center(
                        child: InkWell(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: w * 0.14,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                            child: imageFile == null
                                ? Icon(Icons.camera_alt,
                                size: w * 0.10, color: Colors.grey.shade700)
                                : null,
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      Text("NAME",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: customInput("Enter Name"),
                      ),

                      SizedBox(height: h * 0.02),

                      Text("EMAIL",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: customInput("Enter Email"),
                      ),

                      SizedBox(height: h * 0.02),

                      Text("PASSWORD",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      TextFormField(
                        obscureText: true,
                        decoration: customInput("Enter Password"),
                      ),

                      SizedBox(height: h * 0.02),

                      Text("RE-TYPE PASSWORD",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      TextFormField(
                        obscureText: true,
                        decoration: customInput("Re-enter Password"),
                      ),

                      SizedBox(height: h * 0.03),

                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFF620D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.045,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration customInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}
