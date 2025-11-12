import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';
import '../on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),()async{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      bool onboardingStatus=prefs.getBool("onBoardingStatus") ?? false;
      if(onboardingStatus){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen(),));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/img.png",width: 180,),
      ),
    );
  }
}
