import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/view/screens/add_place_order_address/placeorderAddressUpdate/place_order_address_update_screen.dart';
import 'package:zaykazone/view/screens/orders/case_order_summary_screen.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';
import '../../../controller/place_order_address_provider/place_order_address_provider.dart';

class PaymentScreen extends StatefulWidget {
  final FoodModel? foodData;
  final String? type;
  final double? totalPrice;
  final int? quantity;
  const PaymentScreen({super.key, this.foodData, this.type, this.totalPrice, this.quantity});

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
    final cart = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<PlaceOrderAddressProvider>(context);

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
                  child: Center(
                    child: Text(
                      "Payment",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final selected = selectedPayment == index;

                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedPayment = index;
                          }),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xffFF620D)
                                        : Colors.white24,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      paymentMethods[index]["icon"],
                                      size: 28,
                                      color: const Color(0xffFF620D),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      paymentMethods[index]["title"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  _glassCard(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/img_3.png",
                          height: 60,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "No Mastercard Added\nAdd a new card & save it for later",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, height: 1.4),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddNewCardScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "+ ADD NEW CARD",
                            style: TextStyle(color: Color(0xffFF620D)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _glassCard(
                    child: addressProvider.addressList.isEmpty
                        ? Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlaceOrderAddressUpdateScreen(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xffFF620D),foregroundColor: Colors.white),
                            child: const Text("Add Address"),
                          ),
                        )
                        : Column(
                            children: addressProvider.addressList.map((item) {
                              return Center(
                                child: _glassCard(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.fullAddress,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "Pin: ${item.pinCode} | Mobile: ${item.mobileNumber}",
                                              style: const TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaceOrderAddressUpdateScreen(
                                                        id: item.id),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Edit",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TOTAL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.type == "buy"
                            ? "₹ ${widget.foodData?.price}"
                            : widget.type == "buy_more"
                                ? "₹ ${widget.totalPrice}"
                                : "₹${cart.totalAmount.toInt()}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedPayment > 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Only Cash and UPI Payment Available"),
                            ),
                          );
                          return;
                        }

                        final int paymentIndex = selectedPayment;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CaseOrderSummaryScreen(
                              index: paymentIndex,
                              foodData: widget.type != "cart"
                                  ? widget.foodData
                                  : null,
                              cartItems:
                                  widget.type == "cart" ? cart.cartList : null,
                              type: widget.type ?? "cart",
                              totalPrice: widget.type == "buy_more"
                                  ? widget.totalPrice
                                  : null,
                              quantity: widget.quantity,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF620D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "PAY & CONFIRM",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xffFF620D).withOpacity(0.35),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
