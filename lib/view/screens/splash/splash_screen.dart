import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../login_page/login_screen.dart';
import '../onboarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _waveController;
  late AnimationController _logoController;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      _logoController.forward();
    });

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();

    bool onboard = prefs.getBool("onBoardingStatus") ?? false;
    String? token = await storage.read(key: "auth_token");

    if (!onboard) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );
    } else if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigationBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// 🌊 MOVING WAVES BACKGROUND
          AnimatedBuilder(
            animation: _waveController,
            builder: (_, __) {
              return CustomPaint(
                painter: WavePainter(_waveController.value),
                size: Size.infinite,
              );
            },
          ),

          /// 🧲 MAGNETIC LOGO
          Center(
            child: AnimatedBuilder(
              animation: _logoController,
              builder: (_, child) {
                double t = Curves.easeOutBack.transform(_logoController.value);
                return Transform.translate(
                  offset: Offset(0, 120 * (1 - t)),
                  child: Transform.scale(
                    scale: t,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                "assets/images/app_icon.png",
                width: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🌊 CUSTOM WAVE PAINTER (VERY RARE)
class WavePainter extends CustomPainter {
  final double progress;
  WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFF8C00), // deep orange
          Color(0xFFFF6A00), // darker deep orange




        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.6);

    for (double x = 0; x <= size.width; x++) {
      double y = size.height * 0.6 +
          sin((x / size.width * 2 * pi) + (progress * 2 * pi)) * 30;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}