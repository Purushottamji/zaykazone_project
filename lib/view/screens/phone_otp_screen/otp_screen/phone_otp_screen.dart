import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'dart:ui';
import '../../../../controller/user_auth_provider/login_provider/from_phone/from_phone.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String phone;
  const PhoneOtpScreen({super.key, required this.phone});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PhoneAuthProvider>(context, listen: false).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<PhoneAuthProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
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
                  padding: EdgeInsets.all(18.w),
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
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "OTP sent to Phone Number\n${widget.phone}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                              (index) => _glassOtpBox(auth, index),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// ✅ Verify Button
                      auth.loading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffFF620D),
                            foregroundColor: Colors.white,
                            minimumSize:
                            const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            bool ok = await auth.verifyOtp(widget.phone);
                            if(ok){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BottomNavigationBarScreen(),
                                ),
                                    (_) => false,
                              );
                            }else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid OTP"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Verify OTP",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      auth.isResendAvailable
                          ? InkWell(
                        onTap: () async {
                          bool againOtp = await auth.resendOtp(widget.phone);
                          if (againOtp) {
                            auth.startTimer();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "OTP resent successfully"),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Failed to resend OTP!"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Color(0xffFF620D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          : Text(
                        "Resend in ${auth.timerSeconds}s",
                        style: const TextStyle(
                          color: Colors.white60,
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

  Widget _glassOtpBox(PhoneAuthProvider auth, int index) {
    return SizedBox(
      width: 42.w,
      child: TextField(
        controller: auth.otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white.withOpacity(0.22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (index == 5 && value.isNotEmpty) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}

