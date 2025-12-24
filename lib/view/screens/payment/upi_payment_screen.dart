import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zaykazone/view/screens/payment/success_status_screen.dart';
import 'package:zaykazone/view/screens/payment/payment_failed_screen.dart';
import '../../../controller/cart_provider/cart_provider.dart';
import '../../../services/razorpay_service/raz_api.dart';

class UpiPaymentScreen extends StatefulWidget {
  final double amount;
  final String? type;
  const UpiPaymentScreen({super.key, required this.amount, this.type});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  int? selectedIndex;
  String? selectedUpiApp;
  final TextEditingController upiIdController = TextEditingController();
  bool _isProcessing = false;

  Razorpay? razorpay;

  final List<Map<String, dynamic>> upiApps = [
    {"name": "Google Pay", "icon": Icons.account_balance_wallet, "id": "gpay"},
    {"name": "PhonePe", "icon": Icons.phone_android, "id": "phonepe"},
    {"name": "Paytm", "icon": Icons.payment, "id": "paytm"},
    {"name": "BHIM UPI", "icon": Icons.account_balance, "id": "bhim"},
  ];

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();

    razorpay?.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
            setState(() => _isProcessing = false);
        final cartProvider =
        Provider.of<CartProvider>(context, listen: false);

            if (widget.type != "buy") {
              context.read<CartProvider>().clearItem();
            }

            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const SuccessStatusScreen(title: 'Payment Successful!', message: 'Your payment has been completed successfully.', iconColor: Color(
                0xff03d745),),
          ),
              (route) => false,
        );
      },
    );
    razorpay?.on(
      Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
            setState(() => _isProcessing = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PaymentFailedScreen(),
          ),
        );
      },
    );

    razorpay?.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wallet: ${response.walletName}")),
        );
      },
    );
  }


  @override
  void dispose() {
    razorpay?.clear();
    upiIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    Provider.of<CartProvider>(context);
    const accentColor = Color(0xffFF620D);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("UPI Payment"),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children:[ Container(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight + w * 0.12),

                Align(
                  alignment: Alignment.topCenter,
                  child: _glassCard(
                    child: Column(
                      children: [
                        const Text(
                          "Amount to Pay",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₹${widget.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: w * 0.08,
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: w * 0.08),

                /// 📱 UPI Apps
                Text(
                  "Select UPI App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  height: w * 0.32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: upiApps.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (_, index) {
                      final item = upiApps[index];
                      final isSelected = selectedUpiApp == item["id"];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedUpiApp = item["id"];
                          });
                        },
                        child: _glassCard(
                          width: w * 0.30,
                          borderColor: isSelected
                              ? accentColor
                              : Colors.white24,
                          color: isSelected
                              ? accentColor.withOpacity(0.25)
                              : Colors.white.withOpacity(0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item["icon"],
                                size: w * 0.11,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item["name"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
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
                    color: Colors.white,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                _glassCard(
                  child: TextField(
                    controller: upiIdController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "example@upi",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedIndex == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a UPI App"),
                          ),
                        );
                        return;
                      }

                      var orderId =
                      await ApiHelper.CreateId(widget.amount.toInt());
                      var amount = (widget.amount * 100).toInt();

                      var options = {
                        'key': 'rzp_test_RD0BiIvkAPO6jt',
                        'amount': amount,
                        'name': 'ZaykaZone Food Store',
                        'order_id': orderId,
                        'description': 'Food Order',
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com',
                        }
                      };
                      setState(() => _isProcessing = true);
                      razorpay?.open(options);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: w * 0.045),
                      backgroundColor: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: w * 0.08),
              ],
            ),
          ),
        ),
          if (_isProcessing) _processingLoader(),
    ]
      ),
    );
  }

  Widget _glassCard({
    required Widget child,
    double? width,
    Color? color,
    Color? borderColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor ?? Colors.white24,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _processingLoader() {
    return Container(
      color: Colors.black.withOpacity(0.55),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(
                    color: Color(0xffFF620D),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Processing Payment...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
