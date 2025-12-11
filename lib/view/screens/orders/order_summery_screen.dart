import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/upi_payment_screen.dart';

class OrderSummeryScreen extends StatefulWidget {
  final List cartItems;
  const OrderSummeryScreen({super.key,required this.cartItems});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {

  double totalAmount = 0;
  double delivery = 40;
  double tax = 18;
  double grandTotal = 0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() {
    totalAmount = 0;

    for (var item in widget.cartItems) {
      double price = (item.price ?? 0).toDouble();
      double qty = (item.quantity ?? 0).toDouble();

      totalAmount += price * qty;
    }

    grandTotal = totalAmount + delivery + tax;

    setState(() {});
  }

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
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return buildOrderItem(
                      size,
                      item.title,
                      "${item.quantity} Items",
                      "₹${item.price * item.quantity}",
                      Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          );
                        },
                      ),
                    );
                  },
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
              priceRow("Subtotal", "₹$totalAmount"),
              priceRow("Delivery Charges", "₹$delivery"),
              priceRow("Tax", "₹$tax"),

              Divider(height: size.height * 0.03, thickness: 1),

              priceRow("Total", "₹$grandTotal", isTotal: true),


              SizedBox(height: size.height * 0.03),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpiPaymentScreen(amount: grandTotal)));
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



  Widget buildOrderItem(
      Size size,
      String title,
      String subtitle,
      String price,
      Widget img,   // <-- img now Widget, NOT String
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: size.width * 0.18,
              height: size.width * 0.18,
              child: img,  // <- Network image passed here
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 10),

          Flexible(
            child: Text(
              price,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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





