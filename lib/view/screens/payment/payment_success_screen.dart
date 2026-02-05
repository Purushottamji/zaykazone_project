//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
//
// class PaymentSuccessScreen extends StatefulWidget {
//   const PaymentSuccessScreen({super.key});
//
//   @override
//   State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
// }
//
// class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
//     with TickerProviderStateMixin {
//
//   late AnimationController _iconController;
//   late AnimationController _contentController;
//   late AnimationController _emojiController;
//
//   late Animation<double> _iconScale;
//   late Animation<double> _iconRotate;
//
//   late Animation<double> _fade;
//   late Animation<Offset> _slideUp;
//
//   late Animation<double> _emojiScale;
//   late Animation<Offset> _emojiSlide;
//   late Animation<double> _emojiFade;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _iconController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//
//     _iconScale = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
//     );
//
//     _iconRotate = Tween<double>(begin: -0.4, end: 0).animate(
//       CurvedAnimation(parent: _iconController, curve: Curves.easeOut),
//     );
//
//
//     _contentController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _fade = Tween<double>(begin: 0, end: 1).animate(_contentController);
//     _slideUp = Tween<Offset>(
//       begin: const Offset(0, 0.4),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
//     );
//
//
//     _emojiController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _emojiScale = Tween<double>(begin: 0, end: 1.2).animate(
//       CurvedAnimation(parent: _emojiController, curve: Curves.elasticOut),
//     );
//
//     _emojiSlide = Tween<Offset>(
//       begin: const Offset(0, -1.0), // Start from top
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _emojiController, curve: Curves.easeOutBack),
//     );
//
//     _emojiFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _emojiController, curve: Curves.easeIn),
//     );
//
//
//     _iconController.forward();
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _emojiController.forward();
//     });
//     Future.delayed(const Duration(milliseconds: 500), () {
//       _contentController.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _iconController.dispose();
//     _contentController.dispose();
//     _emojiController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.width * 0.08,
//               vertical: size.height * 0.04,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//
//                 AnimatedBuilder(
//                   animation: _iconController,
//                   builder: (context, child) {
//                     return Transform.rotate(
//                       angle: _iconRotate.value,
//                       child: Transform.scale(
//                         scale: _iconScale.value,
//                         child: child,
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(size.width * 0.07),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.orange.withOpacity(0.15),
//                     ),
//                     child: Icon(
//                       Icons.check_circle,
//                       color: const Color(0xffFF620D),
//                       size: size.width * 0.30,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: size.height * 0.02),
//
//
//                 FadeTransition(
//                   opacity: _emojiFade,
//                   child: SlideTransition(
//                     position: _emojiSlide,
//                     child: ScaleTransition(
//                       scale: _emojiScale,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: size.height * 0.04),
//
//
//                 FadeTransition(
//                   opacity: _fade,
//                   child: SlideTransition(
//                     position: _slideUp,
//                     child: Column(
//                       children: [
//                         Text(
//                           "Order Successful!",
//                           style: TextStyle(
//                             fontSize: size.width * 0.07,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xffFF620D),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: size.height * 0.01),
//                         Text(
//                           "Your order has been processed successfully.",
//                           style: TextStyle(
//                             fontSize: size.width * 0.045,
//                             color: Colors.black54,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: size.height * 0.06),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => BottomNavigationBarScreen(),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xffFF620D),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: size.height * 0.02),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               "Continue",
//                               style: TextStyle(
//                                 fontSize: size.width * 0.045,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with TickerProviderStateMixin {

  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _confettiController;

  late Animation<double> _iconScale;
  late Animation<double> _iconRotate;

  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  final int confettiCount = 50;
  final List<_Confetti> confettiList = [];
  final Random random = Random();

  bool showConfetti = true;

  @override
  void initState() {
    super.initState();

    /// ICON ANIMATION
    _iconController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 900),
    );
    _iconScale = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _iconController, curve: Curves.elasticOut));
    _iconRotate = Tween<double>(begin: -0.5, end: 0).animate(
        CurvedAnimation(parent: _iconController, curve: Curves.easeOut));

    /// TEXT ANIMATION
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textFade = Tween<double>(begin: 0, end: 1).animate(_textController);
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    /// CONFETTI ANIMATION
    _confettiController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    /// INIT CONFETTI
    for (int i = 0; i < confettiCount; i++) {
      confettiList.add(_Confetti(
        x: random.nextDouble(),
        y: random.nextDouble() * -1,
        size: random.nextDouble() * 15 + 5,
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        rotation: random.nextDouble() * 360,
        speed: 0.003 + random.nextDouble() * 0.01,
        shapeType: random.nextInt(4),
      ));
    }

    /// SEQUENCE: ICON → CONFETTI → TEXT
    _iconController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.forward().whenComplete(() {
        // Jab animation complete ho jaye, confetti clean
        setState(() {
          showConfetti = false;
        });
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            /// CONFETTI
            if (showConfetti)
              AnimatedBuilder(
                animation: _confettiController,
                builder: (_, __) {
                  return CustomPaint(
                    size: size,
                    painter: _ConfettiPainter(confettiList, _confettiController.value),
                  );
                },
              ),

            /// CENTER CONTENT
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.height * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// ICON POP
                    AnimatedBuilder(
                      animation: _iconController,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _iconRotate.value,
                          child: Transform.scale(
                            scale: _iconScale.value,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.07),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.withOpacity(0.15),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: const Color(0xffFF620D),
                          size: size.width * 0.30,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),


                    if (showConfetti)
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _confettiController,
                            curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _confettiController,
                              curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
                            ),
                          ),

                        ),
                      ),

                    SizedBox(height: size.height * 0.04),


                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Column(
                          children: [
                            Text(
                              "Order Successful!",
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffFF620D),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Your order has been processed successfully.",
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.06),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BottomNavigationBarScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF620D),
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.02),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _Confetti {
  double x;
  double y;
  double size;
  Color color;
  double rotation;
  double speed;
  int shapeType;

  _Confetti({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.rotation,
    required this.speed,
    required this.shapeType,
  });
}


class _ConfettiPainter extends CustomPainter {
  List<_Confetti> confetti;
  double progress;

  _ConfettiPainter(this.confetti, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var c in confetti) {
      paint.color = c.color;
      double dx = c.x * size.width;
      double dy = ((c.y + progress + c.speed) % 1) * size.height;

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(c.rotation);

      switch (c.shapeType) {
        case 0:
          canvas.drawRect(Rect.fromLTWH(0, 0, c.size / 2, c.size), paint);
          break;
        case 1:
          canvas.drawCircle(Offset(c.size / 2, c.size / 2), c.size / 2, paint);
          break;
        case 2:
          var path = Path();
          path.moveTo(0, c.size);
          path.lineTo(c.size / 2, 0);
          path.lineTo(c.size, c.size);
          path.close();
          canvas.drawPath(path, paint);
          break;
        case 3:
          TextPainter(
            text: TextSpan(text: "🎉", style: TextStyle(fontSize: c.size)),
            textDirection: TextDirection.ltr,
          )
            ..layout(minWidth: 0, maxWidth: c.size * 2)
            ..paint(canvas, Offset(0, 0));
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
