import 'package:flutter/material.dart';

class UpiPaymentScreen extends StatefulWidget {
  final double amount;

  const UpiPaymentScreen({super.key, required this.amount});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  String? selectedUpiApp;
  final TextEditingController upiIdController = TextEditingController();

  List<Map<String, dynamic>> upiApps = [
    {"name": "Google Pay", "icon": Icons.account_balance_wallet, "id": "gpay"},
    {"name": "PhonePe", "icon": Icons.phone_android, "id": "phonepe"},
    {"name": "Paytm", "icon": Icons.payment, "id": "paytm"},
    {"name": "BHIM UPI", "icon": Icons.account_balance, "id": "bhim"},
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("UPI Payment"),
          centerTitle: true,
          backgroundColor: Color(0xffFF620D),
          elevation: 0.5,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: w * 0.06),

              Center(
                child: Container(
                  padding: EdgeInsets.all(w * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Amount to Pay",
                        style: TextStyle(
                          fontSize: w * 0.045,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "₹${widget.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: w * 0.08,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: w * 0.08),

              Text(
                "Select UPI App",
                style: TextStyle(
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              SizedBox(
                height: w * 0.27,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: upiApps.length,
                  separatorBuilder: (_, __) => SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    final item = upiApps[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUpiApp = item["id"];
                        });
                      },
                      child: Container(
                        width: w * 0.28,
                        padding: EdgeInsets.all(w * 0.04),
                        decoration: BoxDecoration(
                          color: selectedUpiApp == item["id"]
                              ? Colors.blue.shade50
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selectedUpiApp == item["id"]
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: selectedUpiApp == item["id"] ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item["icon"], size: w * 0.11),
                            SizedBox(height: 8),
                            Text(
                              item["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: w * 0.08),

              Text(
                "Enter UPI ID (optional)",
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              TextField(
                controller: upiIdController,
                decoration: InputDecoration(
                  hintText: "example@upi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedUpiApp == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a UPI app"),
                        ),
                      );
                      return;
                    }

                    /// TODO: Connect to backend UPI intent API
                    /// Call your Node.js API or UPI payment gateway here

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Paying ₹${widget.amount} via $selectedUpiApp",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: w * 0.045),
                    backgroundColor: Color(0xffFF620D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: w * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
