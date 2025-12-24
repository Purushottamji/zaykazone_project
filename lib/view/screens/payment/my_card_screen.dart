import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';

import '../../../controller/payment_controller/payment_controller.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {

  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userId =context.read<LoginProvider>().userData!["id"];
      Provider.of<PaymentProvider>(context, listen: false).fetchData(userId);
    });
  }

  String maskCard(String card) {
    if (card.length < 4) return card;
    return "**** **** **** ${card.substring(card.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final provider = Provider.of<PaymentProvider>(context);
    // Common Color Constant
    const accentColor = Color(0xffFF620D);

    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show gradient
      extendBodyBehindAppBar: true,
      body: Container(
        // 1. The Background Gradient matching AddNewCardScreen
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
        child: Column(
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.60),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        // Back button or Icon
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text(
                          "My Cards",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // Balancing the row width
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            provider.listData.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        "No cards added",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04, vertical: 20),
                      itemCount: provider.listData.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final item = provider.listData[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.all(w * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // ICON
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.credit_card,
                                      size: w * 0.08,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(width: w * 0.04),

                                  // CARD DETAILS
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.cardHolderName ?? "N/A",
                                          style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          maskCard(item.cardNumber ?? ""),
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            color: Colors.white70,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Exp: ${item.expDate ?? "--"}",
                                          style: TextStyle(
                                            fontSize: w * 0.035,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // DELETE ACTION
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.redAccent),
                                    onPressed: () async {
                                      bool? confirm = await showDialog<bool>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Delete Card"),
                                          content: const Text(
                                              "Are you sure you want to delete this card?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        await provider.deleteData(item.id!);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Card deleted successfully")),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewCardScreen(),
            ),
          );
        },
        label: const Text(
          "Add New Card",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
