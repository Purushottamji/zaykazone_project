import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaykazone/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Center(
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  "Please sign in to your existing account",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("EMAIL", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10.h),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text("PASSWORD", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10.h),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.remove_red_eye),
                                hintText: "Enter your Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'A',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                          Text('Remember me', style: TextStyle(fontSize: 12.sp)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFF620D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 120.w, vertical: 12.h),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account ?',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Center(child: Text("OR", style: TextStyle(fontSize: 13.sp))),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.blue.shade700,
                            child: const Icon(Icons.facebook, color: Colors.white),
                          ),
                          SizedBox(width: 12.w),
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.blueAccent,
                            child: const Icon(Icons.tiktok, color: Colors.white),
                          ),
                          SizedBox(width: 12.w),
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.black,
                            child: const Icon(Icons.apple, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
}
