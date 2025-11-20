import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text("Privacy Policy"),
          centerTitle: true,
          elevation: 0,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Introduction"),
              sectionText(
                "Welcome to ZaykaZone. Your privacy is important to us. This policy "
                    "explains how we collect, use, and protect your information when "
                    "you use our mobile application.",
              ),

              sectionTitle("Information We Collect"),
              bulletPoint("Personal details (Name, Email, Phone Number)"),
              bulletPoint("Delivery address and location details"),
              bulletPoint("Payment information (UPI, Card details via secure gateway)"),
              bulletPoint("Usage data such as search history and app logs"),

              sectionTitle("How We Use Your Data"),
              bulletPoint("To process and deliver your food orders"),
              bulletPoint("To enhance your app experience with personalization"),
              bulletPoint("To communicate order updates and promotions"),
              bulletPoint("To ensure secure transactions and fraud prevention"),

              sectionTitle("Sharing Your Information"),
              sectionText(
                "We do not sell your data. However, we may share necessary information with:\n"
                    "• Delivery partners for order delivery\n"
                    "• Payment gateways for safe transactions\n"
                    "• Analytics tools to improve app performance",
              ),

              sectionTitle("Data Security"),
              sectionText(
                "We use encryption, authentication, and secure servers to protect your personal information from unauthorized access.",
              ),

              sectionTitle("Your Rights"),
              bulletPoint("Access, update, or delete your personal information"),
              bulletPoint("Disable permissions like location anytime"),
              bulletPoint("Opt out of promotional notifications"),

              sectionTitle("Cookies & Tracking"),
              sectionText(
                "We may use cookies and tracking tools to improve your browsing experience and show relevant offers.",
              ),

              sectionTitle("Third-Party Services"),
              sectionText(
                "Our app may contain links to third-party apps or services. We are not responsible for their privacy practices.",
              ),

              sectionTitle("Changes to This Policy"),
              sectionText(
                "We may update our privacy policy occasionally. Continued app usage means you accept the updated policy.",
              ),

              sectionTitle("Contact Us"),
              sectionText(
                "If you have concerns or questions regarding your data, contact us at:\n"
                    "📧 support@zaykazone.com",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade700,
        height: 1.4,
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
