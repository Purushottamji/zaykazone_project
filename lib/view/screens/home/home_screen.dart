import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/view/screens/onboarding/on_boarding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextButton(onPressed: () async{
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setBool("onBoardingStatus", false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen(),));
        }, child: Text("LogOut")),
      ),
    );
  }
}
