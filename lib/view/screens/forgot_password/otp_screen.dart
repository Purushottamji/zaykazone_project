import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers =
  List.generate(4, (index) => TextEditingController());

  int timerSeconds = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timerSeconds == 0) {
        t.cancel();
      } else {
        setState(() => timerSeconds--);
      }
    });
  }

  @override
  void dispose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    timer.cancel();
    super.dispose();
  }

  void verifyOtp() {
    String otp = otpControllers.map((c) => c.text).join();

    if (otp.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter complete OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),

              Text(
                "OTP Verification",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),

              Text(
                "Code sent to ${widget.email}",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),

              SizedBox(height: 40.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: TextField(
                      controller: otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 20.h),

              Text(
                timerSeconds == 0
                    ? "Didn't receive code?"
                    : "Resend code in 00:${timerSeconds.toString().padLeft(2, "0")}",
                style: TextStyle(color: Colors.white70),
              ),

              if (timerSeconds == 0)
                TextButton(
                  onPressed: () {
                    setState(() {
                      timerSeconds = 30;
                      startTimer();
                    });
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(color: Color(0xffFF620D)),
                  ),
                ),

              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF620D),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "VERIFY",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
