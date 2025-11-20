import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  List<Map<String, dynamic>> cards = [
    {
      "brand": "Visa",
      "number": "4242424242424242",
      "expiry": "04/28",
      "default": true,
    },
    {
      "brand": "Mastercard",
      "number": "5555555555554444",
      "expiry": "09/27",
      "default": false,
    },
  ];

  String maskCard(String cardNumber) {
    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Cards"),
          centerTitle: true,
          backgroundColor: Color(0xffFF620D),
          elevation: 0.5,
          foregroundColor: Colors.white,
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardScreen(),));
          },
          label: const Text("Add New Card"),
          icon: const Icon(Icons.add),
          backgroundColor: Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04,vertical: 10),
          child: ListView.separated(
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final card = cards[index];
              return Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: card["default"]
                      ? Colors.blue.shade50
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: card["default"] ? Colors.blue : Colors.grey.shade300,
                    width: card["default"] ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      card["brand"] == "Visa"
                          ? Icons.credit_card
                          : Icons.payment,
                      size: w * 0.09,
                    ),
                    SizedBox(width: w * 0.04),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card["brand"],
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            maskCard(card["number"]),
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Expiry: ${card["expiry"]}",
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cards.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              for (var c in cards) {
                                c["default"] = false;
                              }
                              cards[index]["default"] = true;
                            });
                          },
                          icon: Icon(
                            Icons.check_circle,
                            color: card["default"]
                                ? Colors.blue
                                : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
