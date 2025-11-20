import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../home_screen/Home_Screen.dart';

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

  void submit() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password changed successfully!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigationBarScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8.h),
              Text(
                "Create a new password",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),

              SizedBox(height: 50.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NEW PASSWORD",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp)),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: newPass,
                        obscureText: !showPass1,
                        decoration: InputDecoration(
                          hintText: "Enter new password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                showPass1 ? Icons.visibility : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => showPass1 = !showPass1),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Enter new password";
                          } else if (v.length < 6) {
                            return "Must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 25.h),

                      Text("CONFIRM PASSWORD",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp)),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: confirmPass,
                        obscureText: !showPass2,
                        decoration: InputDecoration(
                          hintText: "Re-enter password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(showPass2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => showPass2 = !showPass2),
                          ),
                        ),
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
                          onPressed: submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF620D),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "RESET PASSWORD",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
