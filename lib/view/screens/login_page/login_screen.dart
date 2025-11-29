import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    var login = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: 220,
                width: double.infinity,
                color: Colors.deepOrange,
                child: Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: login.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        TextFormField(
                          controller: login.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v!.isEmpty ? "Enter email" : null,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Color(0xffFF620D)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffFF620D)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Enter your Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        TextFormField(
                          controller: login.passController,
                          obscureText: login.showPass,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Color(0xffFF620D)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffFF620D)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  login.showPass ? Icons.visibility_off : Icons.visibility
                              ),
                              onPressed: () => login.togglePass(),
                            ),
                            hintText: "Enter your Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

                        Row(
                          children: [
                            Radio<String>(
                              value: 'A',
                              groupValue: login.selectedOption,
                              onChanged: (value) => login.setOption(value),
                            ),
                            Text('Remember me', style: TextStyle(fontSize: 12.sp)),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                                );
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600
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
                                backgroundColor: Color(0xffFF620D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: () async {
                                login.loginUser(context);
                              },
                              child: login.loading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                "Login",
                                style: TextStyle(fontSize: 16.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account ?',
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUpScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),
                  Center(child: Text("OR", style: TextStyle(fontSize: 14.sp))),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => WhatsAppLoginScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 10.sp,
                            backgroundImage: AssetImage("assets/images/whatsApp.png"),
                          ),
                          SizedBox(width: 8.w),
                          Text("Login with WhatsApp",
                              style: TextStyle(color: Colors.white, fontSize: 15.sp)),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PhoneLoginScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text("Login with Phone",
                              style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
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
