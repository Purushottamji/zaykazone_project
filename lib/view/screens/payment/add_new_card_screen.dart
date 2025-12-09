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
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    double cardHeight = height * 0.23;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add New Card"),
          backgroundColor:Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: cardHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFF8C42),
                      Color(0xffFF6A00),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Credit / Debit Card",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Spacer(),
                    const Text(
                      "****  ****  ****  1299",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CARD HOLDER",
                                style: TextStyle(color: Colors.white70)),
                            SizedBox(height: 4),
                            Text("Your Name",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("EXP",
                                style: TextStyle(color: Colors.white70)),
                            SizedBox(height: 4),
                            Text("MM/YY",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 35),

              _buildInput("Card Number", Icons.credit_card, TextInputType.number),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _buildInput(
                        "Expiry Date", Icons.calendar_today, TextInputType.number),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInput(
                        "CVV", Icons.lock_outline, TextInputType.number),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildInput("Card Holder Name", Icons.person, TextInputType.text),

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: saveCard,
                    activeColor: Color(0xffFF620D),
                    onChanged: (val) {
                      setState(() {
                        saveCard = val!;
                      });
                    },
                  ),
                  const Text("Save card for future payments",
                      style: TextStyle(fontSize: 15)),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyCardsScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF620D),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
    );
  }

  Widget _buildInput(
      String label, IconData icon, TextInputType inputType) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xffFF620D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
