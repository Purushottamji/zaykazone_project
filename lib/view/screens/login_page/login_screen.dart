import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/view/screens/email_forgot_password/forgot_password_screen.dart';
import 'package:zaykazone/view/screens/phone_otp_screen/login_screen/phone_login_screen.dart';
import 'package:zaykazone/view/screens/signup/sign_up_screen.dart';
import 'package:zaykazone/view/screens/whatsapp_otp_screen/whatsapp_login_screen/whatsapp_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _glassHeader(),

              SizedBox(height: 25.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 25.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: _loginForm(login),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassHeader() {
    return ClipPath(
      clipper: TopCurveClipper(),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 220,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              color: const Color(0xffFF620D).withOpacity(0.75),
            ),
            child: Column(
              children: const [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Login to your Account",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(LoginProvider login) {
    return Form(
      key: login.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _glassTextField(
            controller: login.emailController,
            keyboardType: TextInputType.emailAddress,
            hint: "Enter your Email",
            icon: Icons.email,
            validator: (v) => v!.isEmpty ? "Enter email" : null,
          ),

          SizedBox(height: 20.h),

          _glassTextField(
            controller: login.passController,
            hint: "Enter your Password",
            icon: Icons.lock,
            obscure: login.showPass,
            suffix: IconButton(
              icon: Icon(
                login.showPass
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: login.togglePass,
            ),
          ),

          SizedBox(height: 15.h),

          Row(
            children: [
              Radio<String>(
                value: 'A',
                groupValue: login.selectedOption,
                activeColor: const Color(0xffFF620D),
                autofocus: true,
                onChanged: login.setOption,
              ),
              Text("Remember me",
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ForgotPasswordScreen()),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          _brandButton(
            text: "Login",
            loading: login.loading,
            onTap: () => login.loginUser(context),
          ),

          SizedBox(height: 20.h),

          _authFooter(),
        ],
      ),
    );
  }

  Widget _glassTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: const Color(0xffFF620D)),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withOpacity(0.20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _brandButton({
    required String text,
    required VoidCallback onTap,
    bool loading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF620D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          text,
          style:
          const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _authFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don’t have an account?",
                style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpScreen()),
                );
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 15.h),
        Text("OR", style: TextStyle(color: Colors.white70)),

        SizedBox(height: 15.h),

        _socialButton(
          color: Colors.green,
          text: "Login with WhatsApp",
          icon: Image.asset("assets/images/whatsApp.png", width: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => WhatsAppLoginScreen()),
            );
          },
        ),

        SizedBox(height: 10.h),

        _socialButton(
          color: Colors.blue,
          text: "Login with Phone",
          icon: Icon(Icons.phone, color: Colors.white, size: 20.sp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PhoneLoginScreen()),
            );
          },
        ),
      ],
    );
  }


  Widget _socialButton({
    required Color color,
    required String text,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 8.w),
            Text(text,
                style:
                TextStyle(color: Colors.white, fontSize: 15.sp)),
          ],
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
