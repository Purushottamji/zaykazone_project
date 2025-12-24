import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_support_screen.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  Future<void> _callPhone() async {
    final uri = Uri.parse("tel:+919876543210");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri.parse(
      "mailto:support@foodapp.com?subject=Support Request",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openMap() async {
    final uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=Food+Plaza+Mumbai",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Icon(
              Icons.check_circle,
              color: accentColor,
              size: 60,
            ),
            content: const Text(
              "Your message has been sent successfully.\nOur support team will contact you shortly.",
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Contact Us"),
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
          padding: EdgeInsets.all(w * 0.05),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight + 30),

              _glassCard(
                height: 170,
                child: const Center(
                  child: Icon(
                    Icons.support_agent,
                    size: 90,
                    color: accentColor,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _contactTile(
                icon: Icons.call,
                title: "Phone Support",
                subtitle: "+91 98765 43210",
                onTap: _callPhone,
              ),

              _contactTile(
                icon: Icons.email_outlined,
                title: "Email Us",
                subtitle: "support@foodapp.com",
                onTap: _sendEmail,
              ),

              _contactTile(
                icon: Icons.location_on_outlined,
                title: "Our Office",
                subtitle: "Food Plaza, Mumbai",
                onTap: _openMap,
              ),

              _contactTile(
                icon: Icons.chat,
                title: "Chat with Support",
                subtitle: "Instant help from our team",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LiveChatSupportScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Send a Message",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _glassTextField("Full Name"),
                    const SizedBox(height: 12),
                    _glassTextField("Email"),
                    const SizedBox(height: 12),
                    _glassTextField("Message", maxLines: 4),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showSuccessDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 10,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🧊 Glass Card
  Widget _glassCard({required Widget child, double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white24),
          ),
          child: child,
        ),
      ),
    );
  }

  /// 📋 Contact Tile
  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _glassCard(
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: accentColor.withOpacity(0.2),
            child: Icon(icon, color: accentColor),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  /// ✍️ Glass TextField
  Widget _glassTextField(String hint, {int maxLines = 1}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}
