import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../../controller/user_auth_provider/forgot_password_provider/forgot_password_provider.dart';
import '../login_page/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  bool showPass1 = false;
  bool showPass2 = false;

  @override
  void dispose() {
    newPass.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    final provider =
    Provider.of<ForgotPasswordProvider>(context, listen: false);

    final success = await provider.resetPassword(newPass.text.trim());

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgotPasswordProvider>();

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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: EdgeInsets.all(22.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "Create a new password",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "NEW PASSWORD",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            _glassPasswordField(
                              controller: newPass,
                              hint: "Enter new password",
                              obscure: !showPass1,
                              toggle: () =>
                                  setState(() => showPass1 = !showPass1),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Enter new password";
                                } else if (v.length < 6) {
                                  return "Minimum 6 characters";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 25.h),

                            const Text(
                              "CONFIRM PASSWORD",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            _glassPasswordField(
                              controller: confirmPass,
                              hint: "Re-enter password",
                              obscure: !showPass2,
                              toggle: () =>
                                  setState(() => showPass2 = !showPass2),
                              validator: (v) {
                                if (v != newPass.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 35.h),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                provider.loading ? null : submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xffFF620D),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14.r),
                                  ),
                                ),
                                child: provider.loading
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Text(
                                  "RESET PASSWORD",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.20),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
