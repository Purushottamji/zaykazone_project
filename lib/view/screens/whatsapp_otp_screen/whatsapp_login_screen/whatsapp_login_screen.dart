import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_whatsapp/from_whatsapp_login.dart';
import 'package:zaykazone/view/screens/whatsapp_otp_screen/otp_screen/otp_screen.dart';

class WhatsAppLoginScreen extends StatefulWidget {
  const WhatsAppLoginScreen({super.key});

  @override
  State<WhatsAppLoginScreen> createState() => _WhatsAppLoginScreenState();
}

class _WhatsAppLoginScreenState extends State<WhatsAppLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<WhatsappLoginProvider>(context);
    final width = MediaQuery.of(context).size.width;

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
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                      Image.asset(
                        "assets/images/whatsApp.png",
                        height: 50.h,
                        width: 50.h,
                      ),

                      SizedBox(height: 14.h),

                      RichText(
                        text: TextSpan(
                          text: "Login with",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: const [
                            TextSpan(
                              text: " WhatsApp",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 6.h),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Please enter your",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                          children: const [
                            TextSpan(
                              text: " WhatsApp ",
                              style: TextStyle(color: Colors.green),
                            ),
                            TextSpan(text: "number"),
                          ],
                        ),
                      ),

                      SizedBox(height: 30.h),

                      Form(
                        key: auth.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "WhatsApp Number",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            _glassPhoneField(auth),

                            SizedBox(height: 30.h),

                            auth.loading
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                                : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xffFF620D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.h),
                                ),
                                onPressed: () async {
                                  if (!auth.formKey.currentState!
                                      .validate()) return;

                                  bool ok = await auth.sendOtp(
                                    auth.phoneController.text
                                        .trim(),
                                  );

                                  if (ok) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OtpScreen(
                                          phone: auth.phoneController
                                              .text
                                              .trim(),
                                        ),
                                      ),
                                    );

                                    auth.startTimer();

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "OTP sent to WhatsApp"),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Failed to send OTP"),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "SEND OTP",
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

  Widget _glassPhoneField(WhatsappLoginProvider auth) {
    return TextFormField(
      controller: auth.phoneController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Enter your WhatsApp number",
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.20),
        prefixIcon:
        const Icon(Icons.phone, color: Color(0xffFF620D)),
        prefixText: "+91 ",
        prefixStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your WhatsApp number";
        }
        if (value.length != 10) {
          return "WhatsApp number must be 10 digits";
        }
        return null;
      },
    );
  }
}

