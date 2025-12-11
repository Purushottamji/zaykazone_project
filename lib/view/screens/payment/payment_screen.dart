import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/orders/case_order_summary_screen.dart';
import 'package:zaykazone/view/screens/orders/order_summery_screen.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';
import 'package:zaykazone/view/screens/payment/payment_success_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPayment = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {"icon": Icons.payments_rounded, "title": "Cash"},
    {"icon": Icons.book_online_outlined, "title": "UPI"},
    {"icon": Icons.credit_card_rounded, "title": "Visa"},
    {"icon": Icons.account_balance_wallet, "title": "Wallet"},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var provider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          title: const Text("Payment"),
          centerTitle: true,
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentMethods.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPayment = index;
                        });
                      },
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: width * 0.23,
                            height: height * 0.10,
                            decoration: BoxDecoration(
                              color: selectedPayment == index
                                  ? const Color(0xffFFEEE2)
                                  : const Color(0xffECEDEF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPayment == index
                                    ? const Color(0xffFF620D)
                                    : const Color(0xffFFEEE2),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              paymentMethods[index]["icon"],
                              color:Color(0xffFF620D),
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(paymentMethods[index]["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: const Color(0xffECEDEF),
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/img_3.png",
                      width: width * 0.35,
                      height: height * 0.18,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "No Mastercard Added\nAdd a new card & save it for later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          height: 1.4),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardScreen(),));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      child: const Text(
                        "+ ADD NEW CARD",
                        style: TextStyle(color: Color(0xffFF620D)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("TOTAL:",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),


                  Text("₹${provider.totalAmount.toInt()}",
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    var provider = Provider.of<CartProvider>(context, listen: false);
                    if (selectedPayment == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CaseOrderSummaryScreen(cartItems: provider.cartList)));
                    }
                    else if (selectedPayment == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderSummeryScreen(cartItems: provider.cartList),
                        ),
                      );

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF620D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("PAY & CONFIRM", style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
