import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    final auth=Provider.of<FromWhatsappLogin>(context);
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
            Image.asset("assets/images/whatsApp.png",height: height*0.15,width: width*0.15,),
            RichText(text: TextSpan(text: "Login With",children: <TextSpan>[
              TextSpan(text: " WhatsApp",style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.bold))
            ],style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold))),
            SizedBox(height: 8.h),
            RichText(text: TextSpan(text: "Please enter your",children: <TextSpan>[
              TextSpan(text: " WhatsApp",style:TextStyle(fontSize: 14.sp, color: Colors.green)),
              TextSpan(text: " Number",style:TextStyle(fontSize: 14.sp, color: Colors.black)),
            ],style: TextStyle(fontSize: 14.sp, color: Colors.black))),

            SizedBox(height: 30.h),
            Form(
              key: auth.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WhatsApp Number",
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
                      hintText: "Enter your WhatsApp Number",
                      prefixIcon: const Icon(Icons.phone),
                      prefixText: "+91",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your whatsapp number";
                      }
                      if (value.length != 10) {
                        return "WhatsApp number must be 10 digits";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30.h),
                  auth.loading ? Center(child: const CircularProgressIndicator()):
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
                        String phone=auth.phoneController.text.trim();
                        bool success= await auth.sendOtp(phone);

                        if (auth.formKey.currentState!.validate()) {
                          if(success){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OtpScreen(phone: phone),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("OTP sent your whatsapp number!"),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("Failed to send OTP"),
                              ),
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
