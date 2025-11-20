import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.width * 0.45,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: size.width * 0.28,
                  color: Colors.red,
                ),
              ),

              SizedBox(height: size.height * 0.04),

              Text(
                "Payment Failed",
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "Unfortunately, your payment could not be processed.\n"
                    "Please try again or use another method.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              SizedBox(height: size.height * 0.06),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF620D),
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Try Again",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarScreen(),));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.red,
                        width: 2),
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
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
