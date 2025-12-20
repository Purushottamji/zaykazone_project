import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/payment_provider/payment_provider.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  final int userId = 96;

  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PaymentProvider>(context, listen: false).fetchData(userId);
    });
  }

  String maskCard(String card) {
    if (card.length < 4) return card;
    return "**** **** **** ${card.substring(card.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Cards"),
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),
        body: provider.listData.isEmpty
            ? const Center(child: Text("No cards added"))
            : ListView.builder(
                itemCount: provider.listData.length,
                itemBuilder: (context, index) {
                  final item = provider.listData[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card,
                              size: 40, color: Color(0xffFF620D)),

                          const SizedBox(width: 15),

                          /// CARD DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.cardHolderName ?? "N/A",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  maskCard(item.cardNumber ?? ""),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Exp: ${item.expDate ?? "--"}",
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              bool? confirm = await showDialog<bool>(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text("Delete Card"),
                                  content: const Text(
                                    "Are you sure you want to delete this card?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await provider.deleteData(item.id!);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Card deleted successfully"),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddNewCardScreen()),
            );
          },
          label: const Text("Add New Card"),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
