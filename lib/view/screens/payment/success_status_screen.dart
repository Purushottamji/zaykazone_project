import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';

class SuccessStatusScreen extends StatefulWidget {
  final String title;
  final String message;
  final String buttonText;
  final Color iconColor;

  const SuccessStatusScreen({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = "Continue",
    required this.iconColor
  });

  @override
  State<SuccessStatusScreen> createState() => _SuccessStatusScreenState();
}

class _SuccessStatusScreenState extends State<SuccessStatusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const accentColor = Color(0xffFF620D);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.7,
      upperBound: 1.0,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// ✅ Animated Icon
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (_, child) {
                          return Transform.scale(
                            scale: _controller.value,
                            child: child,
                          );
                        },
                        child: Container(
                          height: size.width * 0.35,
                          width: size.width * 0.35,
                          decoration: BoxDecoration(
                            color: widget.iconColor.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: size.width * 0.22,
                            color: widget.iconColor,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      /// 🎉 Title (Dynamic)
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: size.width * 0.075,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: size.height * 0.015),

                      /// ℹ️ Message (Dynamic)
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.042,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      /// ▶ Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const BottomNavigationBarScreen(),
                              ),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            widget.buttonText,
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
}
