import 'dart:ui';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  static const accentColor = Color(0xffFF620D);

  final List<Map<String, String>> faqList = [
    {
      "question": "How can I track my order?",
      "answer":
      "You can track your order in the 'Orders' section. Real-time updates will be shown there.",
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
      "We accept UPI, Debit/Credit Cards, Net Banking, and Cash on Delivery depending on your location.",
    },
    {
      "question": "How do I apply a coupon?",
      "answer":
      "Go to the 'Offers' section, choose a coupon, or enter a promo code at checkout.",
    },
    {
      "question": "What if my food arrives late?",
      "answer":
      "If your food is delayed, you can contact support or request compensation in the help center.",
    },
    {
      "question": "Can I cancel my order?",
      "answer":
      "Yes, you can cancel an order before the restaurant accepts it. After acceptance, cancellation may not be allowed.",
    },
  ];

  late List<bool> isExpandedList;

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(faqList.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("FAQs"),
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
          padding: const EdgeInsets.only(top: 30.0),
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
              w * 0.05,
              kToolbarHeight + 20,
              w * 0.05,
              20,
            ),
            itemCount: faqList.length,
            itemBuilder: (_, index) => _faqItem(index),
          ),
        ),
      ),
    );
  }

  Widget _faqItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: ExpansionTile(
              tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: Text(
                faqList[index]["question"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 250),
                turns: isExpandedList[index] ? 0.5 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: accentColor,
                ),
              ),
              onExpansionChanged: (expanded) {
                setState(() => isExpandedList[index] = expanded);
              },
              children: [
                Text(
                  faqList[index]["answer"]!,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
