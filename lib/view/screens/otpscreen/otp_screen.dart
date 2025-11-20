import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  bool isResendAvailable = false;
  int timerSeconds = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (timerSeconds == 0) {
        setState(() => isResendAvailable = true);
        return false;
      }
      setState(() => timerSeconds--);
      return true;
    });
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 40),

              Text(
                "Verify OTP",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text(
                "OTP sent to WhatsApp: ${widget.phone}",
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
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
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
                          print("OTP = ${getOtp()}");
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  print("Verify OTP = ${getOtp()}");
                },
                child: Text("Verify OTP", style: TextStyle(fontSize: 18)),
              ),

              SizedBox(height: 20),

              isResendAvailable
                  ? InkWell(
                onTap: () {
                  print("Resend OTP");
                },
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )
                  : Text(
                "Resend in ${timerSeconds}s",
                style: TextStyle(color: Colors.grey),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
