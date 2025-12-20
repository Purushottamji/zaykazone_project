import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/payment_provider/payment_provider.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  final int userId = 96;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<PaymentProvider>(context);
    final cardHeight = height * 0.23;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add New Card"),
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xffFF8C42), Color(0xffFF6A00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                      Text(
                        provider.cartNumberController.text.isEmpty
                            ? "**** **** **** ****"
                            : provider.cartNumberController.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("CARD HOLDER",
                                  style: TextStyle(color: Colors.white70)),
                              Text(
                                provider.cardHolderNameController.text.isEmpty
                                    ? "Your Name"
                                    : provider.cardHolderNameController.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("EXP",
                                  style: TextStyle(color: Colors.white70)),
                              Text(
                                provider.expiryDateController.text.isEmpty
                                    ? "MM/YY"
                                    : provider.expiryDateController.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                /// CARD NUMBER
                TextFormField(
                  controller: provider.cartNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  decoration: _inputDecoration(
                    "Card Number",
                    Icons.credit_card,
                  ),
                  validator: (v) => v!.isEmpty ? "Enter card number" : null,
                  onChanged: (_) => setState(() {}),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: provider.expiryDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: _inputDecoration(
                            "Expiry Date", Icons.calendar_today),
                        validator: (v) =>
                            v!.isEmpty ? "Enter expiry date" : null,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: provider.cvvController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 3,
                        decoration: _inputDecoration("CVV", Icons.lock_outline),
                        validator: (v) => v!.length < 3 ? "Invalid CVV" : null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                TextFormField(
                  controller: provider.cardHolderNameController,
                  decoration:
                      _inputDecoration("Card Holder Name", Icons.person),
                  validator: (v) =>
                      v!.isEmpty ? "Enter card holder name" : null,
                  onChanged: (_) => setState(() {}),
                ),

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
                    const Text("Save card for future payments"),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      await provider.postData(userId);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF620D),
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
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xffFF620D)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
