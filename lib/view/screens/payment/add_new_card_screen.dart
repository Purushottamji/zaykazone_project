import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/my_card_screen.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cardHeight = height * 0.25;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
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
                  color: const Color(0xffFF620D).withOpacity(0.60),
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
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        "Add New Card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: cardHeight,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Color(0xffff620d).withOpacity(0.80),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: const Color(0xffFF620D).withOpacity(0.35),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Credit / Debit Card",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 15),
                              ),
                              const Spacer(),
                              const Text(
                                "****  ****  ****  1299",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("CARD HOLDER",
                                          style:
                                              TextStyle(color: Colors.white60)),
                                      SizedBox(height: 4),
                                      Text("Your Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("EXP",
                                          style:
                                              TextStyle(color: Colors.white60)),
                                      SizedBox(height: 4),
                                      Text("MM/YY",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    _glassInput(
                        "Card Number", Icons.credit_card, TextInputType.number),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _glassInput("Expiry Date",
                              Icons.calendar_today, TextInputType.number),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _glassInput(
                              "CVV", Icons.lock_outline, TextInputType.number),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _glassInput(
                        "Card Holder Name", Icons.person, TextInputType.text),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: saveCard,
                          activeColor: const Color(0xffFF620D),
                          onChanged: (val) {
                            setState(() => saveCard = val!);
                          },
                        ),
                        const Text(
                          "Save card for future payments",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MyCardsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF620D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text(
                          "SAVE CARD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassInput(String label, IconData icon, TextInputType inputType) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextFormField(
          keyboardType: inputType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white70),
            prefixIcon: Icon(icon, color: const Color(0xffFF620D)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
