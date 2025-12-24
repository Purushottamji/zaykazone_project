import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int currentStep = 0;
  Timer? _timer;

  /// 🔹 Step data (replaces Stepper)
  final List<Map<String, String>> orderSteps = [
    {
      "title": "Order Placed",
      "subtitle": "Your order has been placed successfully"
    },
    {
      "title": "Packed",
      "subtitle": "Your items are packed and ready to ship"
    },
    {
      "title": "Shipped",
      "subtitle": "Order is on the way to your city"
    },
    {
      "title": "Out for Delivery",
      "subtitle": "Delivery partner is on the way"
    },
    {
      "title": "Delivered",
      "subtitle": "Order delivered successfully"
    },
  ];

  @override
  void initState() {
    super.initState();
    startAutoTracking();
  }

  void startAutoTracking() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentStep < orderSteps.length - 1) {
        setState(() => currentStep++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Track Order"),
        centerTitle: true,
        backgroundColor: TrackOrderScreen.accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.06,
            kToolbarHeight + 20,
            size.width * 0.06,
            20,
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: ListView.builder(
                        itemCount: orderSteps.length,
                        padding: EdgeInsets.only(top: 20),
                        itemBuilder: (_, index) {
                          final isCompleted = index <= currentStep;
                          final isLast =
                              index == orderSteps.length - 1;

                          return _timelineTile(
                            title: orderSteps[index]["title"]!,
                            subtitle: orderSteps[index]["subtitle"]!,
                            isCompleted: isCompleted,
                            isLast: isLast,
                            height: size.height * 0.09,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // View invoice
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TrackOrderScreen.accentColor,
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 10,
                      ),
                      child: Text(
                        "View Invoice",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: TrackOrderScreen.accentColor, width: 2),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Back Home",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _timelineTile({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
    required double height,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.greenAccent : Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 3,
                height: height,
                color:
                isCompleted ? Colors.greenAccent : Colors.white24,
              ),
          ],
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted
                        ? Colors.greenAccent
                        : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
