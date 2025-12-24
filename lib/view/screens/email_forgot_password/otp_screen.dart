import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/user_auth_provider/forgot_password_provider/forgot_password_provider.dart';
import 'reset_password_screen.dart';


class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());

  int timerSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timerSeconds = 30;

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
    timer?.cancel();
    super.dispose();
  }

  String getOtp() {
    return otpControllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgotPasswordProvider>();
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
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
                        "OTP Verification",
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "Code sent to ${widget.email}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40.h),

                      /// 🔢 OTP Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return _glassOtpBox(index);
                        }),
                      ),

                      SizedBox(height: 16.h),

                      /// ⏱ Timer
                      Text(
                        timerSeconds == 0
                            ? "Didn't receive code?"
                            : "Resend code in 00:${timerSeconds.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: Colors.white70),
                      ),

                      if (timerSeconds == 0)
                        TextButton(
                          onPressed: provider.loading
                              ? null
                              : () async {
                            await provider.sendOtp(widget.email);
                            startTimer();
                          },
                          child: const Text(
                            "Resend OTP",
                            style:
                            TextStyle(color: Color(0xffFF620D)),
                          ),
                        ),

                      SizedBox(height: 24.h),

                      /// ✅ Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: provider.loading
                              ? null
                              : () async {
                            final otp = getOtp();

                            if (otp.length != 4) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content:
                                  Text("Enter complete OTP"),
                                ),
                              );
                              return;
                            }

                            final success =
                            await provider.verifyOtp(otp);

                            if (success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const ResetPasswordScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Invalid or expired OTP"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffFF620D),
                            padding:
                            EdgeInsets.symmetric(vertical: 14.h),
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
                            "VERIFY",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🧊 Glass OTP Box
  Widget _glassOtpBox(int index) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: TextField(
        controller: otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
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
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

