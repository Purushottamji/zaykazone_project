import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:zaykazone/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:zaykazone/view/screens/signup/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedOption;

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool showPass2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.h),

            Center(
              child: Text(
                "Log In",
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
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
                          Text(
                            "EMAIL",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: email,
                            obscureText: showPass2,
                            decoration: InputDecoration(
                              hintText: "Enter your Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    showPass2 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () =>
                                    setState(() => showPass2 = !showPass2),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          Text(
                            "PASSWORD",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
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
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        Text('Remember me', style: TextStyle(fontSize: 12.sp)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            );
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
                    SizedBox(height: 10.h),

                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF620D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const BottomNavigationBarScreen()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account ?',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
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
                    SizedBox(height: 10.h),

                    Center(
                      child: Text("OR", style: TextStyle(fontSize: 14.sp)),
                    ),
                    SizedBox(height: 15.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CircleAvatar(radius: 10.sp,backgroundImage: AssetImage("assets/images/whatsApp.png"),),
                            SizedBox(width: 8.w),
                            Text(
                              "Login with WhatsApp",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone,
                                color: Colors.white, size: 20.sp),
                            SizedBox(width: 8.w),
                            Text(
                              "Login with Phone",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
