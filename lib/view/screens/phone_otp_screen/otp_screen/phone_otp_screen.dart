import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_whatsapp/from_whatsapp_login.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';

import '../../../../controller/user_auth_provider/login_provider/from_phone/from_phone.dart';
import '../../home_screen/Home_Screen.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String phone;
  const PhoneOtpScreen({super.key, required this.phone, });

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {

  @override
  void initState() {
    super.initState();
    var provider=Provider.of<PhoneAuthProvider>(context,listen: false).startTimer();
    provider;
  }


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<PhoneAuthProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(height: 100.h),

              Text(
                "Verify OTP",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text(
                "OTP sent to Phone Number: ${widget.phone}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: width * 0.1,
                    child: TextField(
                      controller: auth.controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFF620D)),borderRadius: BorderRadius.circular(12)),
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (index == 5 && value.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          print("OTP = ${auth.getOtp()}");
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 30),
              auth.loading ? const CircularProgressIndicator():
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF620D),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () async{
                  String otp=auth.getOtp();
                  print("Verify OTP = $otp");

                  if(otp.length !=6){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter full 6-digit OTP")));
                    return;
                  }
                  bool success= await auth.verifyOtp(widget.phone, otp);
                  if (success) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BottomNavigationBarScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid OTP")),
                    );
                  }
                },
                child: Text("Verify OTP", style: TextStyle(fontSize: 18)),
              ),

              SizedBox(height: 20),

              auth.isResendAvailable
                  ? InkWell(
                onTap: () async {
                  bool againOtp = await auth.sendOtp(context, widget.phone);
                  if (againOtp) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP resent successfully")),
                    );
                    auth.startTimer();
                  }
                },
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      color: Color(0xffFF620D),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )
                  : Text(
                "Resend in ${auth.timerSeconds}s",
                style: TextStyle(color: Colors.grey),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
