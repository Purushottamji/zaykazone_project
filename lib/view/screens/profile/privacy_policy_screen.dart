import 'dart:ui';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            w * 0.05,
            kToolbarHeight + 20,
            w * 0.05,
            30,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Introduction"),
                    _sectionText(
                      "Welcome to ZaykaZone. Your privacy is important to us. This policy "
                          "explains how we collect, use, and protect your information when "
                          "you use our mobile application.",
                    ),

                    _sectionTitle("Information We Collect"),
                    _bullet("Personal details (Name, Email, Phone Number)"),
                    _bullet("Delivery address and location details"),
                    _bullet("Payment information via secure gateways"),
                    _bullet("Usage data such as search history and logs"),

                    _sectionTitle("How We Use Your Data"),
                    _bullet("To process and deliver food orders"),
                    _bullet("To personalize your app experience"),
                    _bullet("To send order updates and promotions"),
                    _bullet("For fraud prevention and security"),

                    _sectionTitle("Sharing Your Information"),
                    _sectionText(
                      "We do not sell your data. We may share required information with:\n"
                          "• Delivery partners\n"
                          "• Payment gateways\n"
                          "• Analytics tools",
                    ),

                    _sectionTitle("Data Security"),
                    _sectionText(
                      "We use encryption, authentication, and secure servers to "
                          "protect your data from unauthorized access.",
                    ),

                    _sectionTitle("Your Rights"),
                    _bullet("Access, update, or delete your data"),
                    _bullet("Disable permissions anytime"),
                    _bullet("Opt out of promotional notifications"),

                    _sectionTitle("Cookies & Tracking"),
                    _sectionText(
                      "Cookies and tracking tools may be used to improve experience "
                          "and show relevant offers.",
                    ),

                    _sectionTitle("Third-Party Services"),
                    _sectionText(
                      "We are not responsible for privacy practices of third-party "
                          "services linked in the app.",
                    ),

                    _sectionTitle("Policy Updates"),
                    _sectionText(
                      "Policy may be updated occasionally. Continued usage means "
                          "acceptance of changes.",
                    ),

                    _sectionTitle("Contact Us"),
                    _sectionText(
                      "📧 support@zaykazone.com",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Section Title
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 🔹 Section Text
  Widget _sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14.5,
        height: 1.5,
      ),
    );
  }

  /// 🔹 Bullet Point
  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
