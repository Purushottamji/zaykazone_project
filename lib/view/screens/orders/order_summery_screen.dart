import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/my_card_screen.dart';
import 'package:zaykazone/view/screens/payment/payment_failed_screen.dart';
import 'package:zaykazone/view/screens/payment/payment_success_screen.dart';
import 'package:zaykazone/view/screens/payment/upi_payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Your Order",
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.015),

              Expanded(
                child: ListView(
                  children: [
                    buildOrderItem(
                      size,
                      "Burger",
                      "2 Items",
                      "₹120",
                      "assets/images/berger.jpg",
                    ),
                    buildOrderItem(
                      size,
                      "Pizza",
                      "1 Item",
                      "₹220",
                      "assets/images/pizza1.jpg",
                    ),
                    buildOrderItem(
                      size,
                      "French Fries",
                      "1 Item",
                      "₹80",
                      "assets/images/french_fries.jpg",
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "Price Details",
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.01),

              priceRow("Subtotal", "₹420"),
              priceRow("Delivery Charges", "₹40"),
              priceRow("Tax", "₹18"),

              Divider(height: size.height * 0.03, thickness: 1),

              priceRow("Total", "₹478", isTotal: true),

              SizedBox(height: size.height * 0.03),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => UpiPaymentScreen(amount: 478)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF620D),
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Confirm Order",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(Size size, String title, String subtitle,
      String price, String img) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              width: size.width * 0.18,
              height: size.width * 0.18,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.04),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 5),
                Text(subtitle,
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: Colors.black54,
                    )),
              ],
            ),
          ),

          Text(
            price,
            style: TextStyle(
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget priceRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
