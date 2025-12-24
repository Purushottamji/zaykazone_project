import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:zaykazone/controller/user_auth_provider/signup_provider/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<SignupProvider>(context);
    final w = MediaQuery
        .of(context)
        .size
        .width;
    final h = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D), // 🔥 brand glow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            _glassHeader(register),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: EdgeInsets.all(w * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: _signUpForm(register, w, h),
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _glassHeader(SignupProvider register) {
    return ClipPath(
      clipper: TopClipPath(),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 40,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffFF620D).withOpacity(0.75),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                  ),
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
                const SizedBox(height: 6),
                const Text(
                  "Please create your Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),

                InkWell(
                  onTap: () => register.pickImage(ImageSource.gallery),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: register.imageFile != null
                        ? FileImage(register.imageFile!)
                        : null,
                    child: register.imageFile == null
                        ? Icon(Icons.camera_alt,
                        size: 32, color: Colors.grey.shade700)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpForm(SignupProvider register, double w, double h) {
    return Form(
      key: register.formKey,
      child: Column(
        children: [
          _glassInput(
            controller: register.nameController,
            hint: "Enter Name",
            validator: (v) =>
            v == null || v.isEmpty ? "Please Enter your Name" : null,
          ),
          SizedBox(height: h * 0.02),

          _glassInput(
            controller: register.emailController,
            hint: "Enter Email",
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return "Please Enter your email";
              if (!v.contains("@") || !v.contains(".")) {
                return "Email must be valid";
              }
              return null;
            },
          ),
          SizedBox(height: h * 0.02),

          _glassInput(
            controller: register.phoneController,
            hint: "Enter Phone",
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.isEmpty) return "Please Enter your Phone";
              if (v.length != 10) return "Phone must be 10 digits";
              return null;
            },
          ),
          SizedBox(height: h * 0.02),

          _glassPasswordField(
            controller: register.passwordController,
            hint: "Enter Password",
            obscure: register.showPass1,
            toggle: register.togglePass1,
          ),
          SizedBox(height: h * 0.02),

          _glassPasswordField(
            controller: register.cPasswordController,
            hint: "Re-enter Password",
            obscure: register.showPass2,
            toggle: register.togglePass2,
          ),
          SizedBox(height: h * 0.03),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF620D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => register.registerUser(context),
              child: Text(
                "SIGN UP",
                style: TextStyle(color: Colors.white, fontSize: w * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassInput({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _glassPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.20),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye,
            color: Colors.white70,
          ),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
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