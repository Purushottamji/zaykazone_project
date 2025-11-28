import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/phone_otp_screen/otp_screen/phone_otp_screen.dart';
import 'package:zaykazone/view/screens/whatsapp_otp_screen/otp_screen/otp_screen.dart';

import '../../../../controller/user_auth_provider/login_provider/from_phone/from_phone.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<PhoneAuthProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 80.h),
            Image.asset("assets/images/telephone.png",height: height*0.15,width: width*0.15,),
            RichText(text: TextSpan(text: "Login With",children: <TextSpan>[
              TextSpan(text: " Phone",style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff0B99D5),
                  fontWeight: FontWeight.bold))
            ],style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold))),
            SizedBox(height: 8.h),
            RichText(text: TextSpan(text: "Please enter your",children: <TextSpan>[
              TextSpan(text: " Phone",style:TextStyle(fontSize: 14.sp, color: Color(0xff0B99D5))),
              TextSpan(text: " Number",style:TextStyle(fontSize: 14.sp, color: Colors.black)),
            ],style: TextStyle(fontSize: 14.sp, color: Colors.black))),

            SizedBox(height: 30.h),
            Form(
              key: auth.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),

                  SizedBox(height: 12.h),

                  TextFormField(
                    controller: auth.phoneController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFF620D)),borderRadius: BorderRadius.circular(12)),
                      hintText: "Enter your Phone Number",
                      prefixIcon: const Icon(Icons.phone),
                      prefixText: "+91",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      }
                      if (value.length != 10) {
                        return "phone number must be 10 digits";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30.h),
                  auth.loading
                      ? Center(child: const CircularProgressIndicator()):
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF620D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 20.w),
                      ),
                      onPressed: () async{
                        if (auth.formKey.currentState!.validate()) {

                          String phone = auth.phoneController.text.trim();

                          bool ok = await auth.sendOtp(context, phone);

                          if (ok) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PhoneOtpScreen(phone: phone),
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("OTP sent to phone!")),
                            );

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Failed to send OTP")),
                            );
                          }
                        }
                      },
                      child: Text(
                        "SEND OTP",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
