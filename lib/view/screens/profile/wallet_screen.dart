import 'dart:ui';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("My Wallet"),
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
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            w * 0.05,
            kToolbarHeight + 20,
            w * 0.05,
            20,
          ),
          children: [
            const SizedBox(height: 30),
            _walletBalanceCard(),

            const SizedBox(height: 30),

            const Text(
              "Recent Transactions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 15),
              itemCount: 6,
              itemBuilder: (_, index) => _transactionTile(index),
            ),
          ],
        ),
      ),
    );
  }

  /// 💰 Wallet Balance Card
  Widget _walletBalanceCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "₹ 1,250.50",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  // Add money flow
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Add Money"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📄 Transaction Tile
  Widget _transactionTile(int index) {
    final isCredit = index % 2 == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                /// 🔄 Icon
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accentColor.withOpacity(0.2),
                  child: Icon(
                    isCredit
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: isCredit ? Colors.greenAccent : Colors.redAccent,
                  ),
                ),

                const SizedBox(width: 14),

                /// 📄 Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCredit ? "Money Added" : "Order Payment",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "20 Nov 2025",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 💵 Amount
                Text(
                  isCredit ? "+₹200" : "-₹350",
                  style: TextStyle(
                    color:
                    isCredit ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
