import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';
import '../../../services/razorpay_service/raz_api.dart';

class UpiPaymentScreen extends StatefulWidget {
  final double amount;

  const UpiPaymentScreen({super.key, required this.amount});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  int? selectedIndex;
  String? selectedUpiApp;
  final TextEditingController upiIdController = TextEditingController();


  List<Map<String, dynamic>> upiApps = [
    {"name": "Google Pay", "icon": Icons.account_balance_wallet, "id": "gpay"},
    {"name": "PhonePe", "icon": Icons.phone_android, "id": "phonepe"},
    {"name": "Paytm", "icon": Icons.payment, "id": "paytm"},
    {"name": "BHIM UPI", "icon": Icons.account_balance, "id": "bhim"},
  ];

  Razorpay? razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse success){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Successfully ${success.paymentId}")));
    });
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed")));
    });
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse wallet)=>{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Wallet")))
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
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
              SizedBox(height: w * 0.010),
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
                      Text("₹${widget.amount.toStringAsFixed(2)}",
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
                height: w * 0.30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: upiApps.length,
                  separatorBuilder: (_, __) => SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    final item = upiApps[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedUpiApp = item["id"];
                        });
                      },
                      child: Container(
                        width: w * 0.30,
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
                      onPressed: () async{
                        if (selectedIndex == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select a UPI App")),
                          );
                          return;
                        }

                        // int amount = provider.totalAmount.toInt();
                        // String? orderId = await ApiHelper.CreateId(amount);
                        // if (orderId == null || orderId.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text("Something went wrong creating order")),
                        //   );
                        //   return;
                        // }
                        //
                        // var options = {
                        //   'key': 'rzp_test_RD0BiIvkAPO6jt',
                        //   'amount': amount * 100,
                        //   'name': 'Zayka Zone',
                        //   'order_id': orderId,
                        //   'prefill': {
                        //     'contact': '8888888888',
                        //     'email': 'test@razorpay.com',
                        //   }
                        // };
                        // razorpay?.open(options);

                        var orderId=await ApiHelper.CreateId(provider.totalAmount.toInt());
                        var amount = (widget.amount * 100).toInt();

                        var option = {
                          'key': 'rzp_test_RD0BiIvkAPO6jt',
                          'amount': "$amount",
                          'name': 'Acme Corp.',
                          'order_id': orderId,
                          'description': 'Fine T-Shirt',
                          'prefill': {
                            'contact': '8888888888',
                            'email': 'test@razorpay_service.com'
                          }
                        };
                        razorpay?.open(option);
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
