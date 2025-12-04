import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/signup_provider/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisible = false;
  bool rePasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var register = Provider.of<SignupProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ClipPath(
            clipper: TopClipPath(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Color(0xffFF620D),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// back button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "Sign Up Now",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Please create your account",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  /// Image Picker
                  InkWell(
                    onTap: () {
                      register.pickImage(ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: register.imageFile != null
                          ? FileImage(register.imageFile!)
                          : null,
                      child: register.imageFile == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 35,
                        color: Colors.grey.shade700,
                      )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Form Section
          Form(
            key: register.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),

                  // Name
                  TextFormField(
                    controller: register.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Name";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Name"),
                  ),
                  SizedBox(height: h * 0.02),

                  // Email
                  TextFormField(
                    controller: register.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your email";
                      }
                      if (!value.contains("@") || !value.contains(".com")) {
                        return "Email must be valid";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Email"),
                  ),
                  SizedBox(height: h * 0.02),

                  // Phone
                  TextFormField(
                    controller: register.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Phone";
                      }
                      if (value.length != 10) {
                        return "Phone must be 10 digits";
                      }
                      return null;
                    },
                    decoration: customInput("Enter Phone"),
                  ),
                  SizedBox(height: h * 0.02),

                  // Password
                  TextFormField(
                    controller: register.passwordController,
                    obscureText: register.showPass1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffFF620D)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: register.togglePass1,
                        icon: register.showPass1
                            ? const Icon(CupertinoIcons.eye_slash_fill)
                            : const Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),

                  // Re-Password
                  TextFormField(
                    controller: register.cPasswordController,
                    obscureText: register.showPass2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Re-enter Password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffFF620D)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: register.togglePass2,
                        icon: register.showPass2
                            ? const Icon(CupertinoIcons.eye_slash_fill)
                            : const Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),

                  /// Sign Up Button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF620D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          register.registerUser(context);
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration customInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffFF620D)),
      ),
    );
  }
}

class TopClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
