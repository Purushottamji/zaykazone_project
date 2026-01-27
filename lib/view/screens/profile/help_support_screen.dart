import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/help_support_provider/help_support_provider.dart';
import 'package:zaykazone/view/screens/profile/chat_support_screen.dart';
import 'package:zaykazone/view/screens/profile/faqs_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Help & Support"),
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            w * 0.05,
            kToolbarHeight + 16,
            w * 0.05,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              _glassSearchField(),
              const SizedBox(height: 22),
              const Text(
                "Quick Help",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 100,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _quickAction(Icons.help_outline, "FAQs",() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen(),));
                    },),
                    _quickAction(Icons.chat, "Live Chat",() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LiveChatSupportScreen(),));
                    },),
                    _quickAction(Icons.phone, "Call Us",() {
                      HelpSupportProvider.makeACall(context);
                    },),
                  ],
                ),
              ),

              const SizedBox(height: 22),
              const Text(
                "Popular Topics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 15),
                  children: [
                    _topicTile("Order not delivered"),
                    _topicTile("Payment failed"),
                    _topicTile("Refund not received"),
                    _topicTile("Account issues"),
                    _topicTile("App not working"),
                    _topicTile("Coupons not applying"),
                    _topicTile("Delivery partner issue"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: ElevatedButton.icon(
          onPressed: () {
            // Navigate to LiveChatSupportScreen
          },
          icon: const Icon(Icons.support_agent),
          label: const Text("Chat with Support"),
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 10,
          ),
        ),
      ),
    );
  }

  Widget _glassSearchField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search help topics...",
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String title,VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24),
                ),
                child: Icon(icon, size: 26, color: accentColor),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _topicTile(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white54,
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
