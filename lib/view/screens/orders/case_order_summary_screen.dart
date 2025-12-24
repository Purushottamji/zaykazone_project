import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/cart_provider/cart_provider.dart';
import 'package:zaykazone/model/cart_modal/cart_modal.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/view/screens/payment/success_status_screen.dart';
import 'dart:ui';
import 'package:zaykazone/view/screens/payment/upi_payment_screen.dart';
import '../../../controller/order_provider/order_provider.dart';
import '../../../controller/place_order_address_provider/place_order_address_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';

class CaseOrderSummaryScreen extends StatefulWidget {
  final List<CartModel>? cartItems;
  final int index;
  final FoodModel? foodData;
  final String type;
  final double? totalPrice;
  const CaseOrderSummaryScreen(
      {super.key, this.cartItems, required this.index, this.foodData,required this.type, this.totalPrice});

  @override
  State<CaseOrderSummaryScreen> createState() => _CaseOrderSummaryScreenState();
}

class _CaseOrderSummaryScreenState extends State<CaseOrderSummaryScreen> {
  double totalAmount = 0;
  double delivery = 20;
  double tax = 10;
  double grandTotal = 0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() {
    totalAmount = 0;

    if (widget.type == "buy") {
      final price =
          double.tryParse(widget.foodData?.price.toString() ?? "0") ?? 0;
      final qty = widget.foodData?.quantity ?? 0;

      totalAmount = price * qty;
    } else if(widget.type=="buy_more"){
      final price =
          double.tryParse(widget.totalPrice.toString() ?? "0") ?? 0;
      final qty = widget.foodData?.quantity ?? 0;

      totalAmount = price * qty;
    }
    else {
      if (widget.cartItems != null) {
        for (var item in widget.cartItems!) {
          final price =
              double.tryParse(item.price.toString()) ?? 0;
          final qty = item.quantity ?? 0;

          totalAmount += price * qty;
        }
      }
    }

    grandTotal = totalAmount + delivery + tax;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: Column(
          children: [
            _glassAppBar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Your Order"),
                    Expanded(

                      child: widget.type=="buy" ? ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final item = widget.foodData;
                          final price =
                              double.tryParse(item!.price.toString()) ?? 0;

                         return _glassOrderItem(
                            size,
                            item.name,
                            "${item.quantity} Items",
                            "₹${price * item.quantity}",
                            item.image,
                          );

                        },
                      ): widget.type == "buy_more"?ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final item = widget.foodData;
                          final price =
                              double.tryParse(item!.price.toString()) ?? 0;

                          return _glassOrderItem(
                            size,
                            item.name,
                            "${item.quantity} Items",
                            "₹${price * item.quantity}",
                            item.image,
                          );

                        },
                      ):ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: widget.cartItems?.length,
                        itemBuilder: (context, index) {
                          final item = widget.cartItems?[index];
                          if (item == null) return const SizedBox();

                          final price = double.tryParse(item.price?.toString() ?? "0") ?? 0;
                          final qty = item.quantity ?? 0;

                         return _glassOrderItem(
                            size,
                            item.title,
                            "${item.quantity} Items",
                            "₹${price * qty}",
                            item.image,
                          );

                        },
                      ),
                    ),

                    _sectionTitle("Price Details"),
                    _priceRow("Subtotal", "₹$totalAmount"),
                    _priceRow("Delivery", "₹$delivery"),
                    _priceRow("Tax", "₹$tax"),


                    const Divider(color: Colors.white30),

                    _priceRow("Total", "₹$grandTotal", isTotal: true),

                    const SizedBox(height: 20),

                    _confirmButton(size),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Color(0xffff620d).withOpacity(0.60),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
          child: const Center(
            child: Text(
              "Order Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _glassOrderItem(
    Size size,
    String title,
    String subtitle,
    String price,
    String image,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xffFF620D).withOpacity(0.4),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Text(price,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _confirmButton(Size size) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final loginProvider = context.read<LoginProvider>();
          final addressProvider = context.read<PlaceOrderAddressProvider>();
          final orderProvider = context.read<OrderProvider>();

          final userId = loginProvider.userData?['id'];
          if (userId == null || addressProvider.addressList.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("User or address not found")),
            );
            return;
          }

          final addressId = addressProvider.addressList.first.id;
          if (orderProvider.isPlacingOrder) return;
          if (widget.index == 0) {
            if (widget.type == "buy" || widget.type == "buy_more") {
              final food = widget.foodData!;
              final price = double.parse(food.price.toString());
              print(food.image);
              await orderProvider.buyNow(
                userId: userId,
                resId: food.restaurantId,
                foodName: food.name,
                quantity: food.quantity,
                totalPrice: price * food.quantity,
                image: food.image,
                addressId: addressId!,
                context: context,
              );
            }else{
              await orderProvider.checkoutCart(
                userId: userId,
                resId: widget.cartItems!.first.resId,
                cartItems: widget.cartItems,
                addressId: addressId!,
                context: context,
              );
              context.read<CartProvider>().clearItem();
            }
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const SuccessStatusScreen(
                    title: "Order Successful!",
                    message: "Your order has been placed successfully.",
                    buttonText: "Go to Home", iconColor: Color(0xffFF620D),
                  ),
                ),
                    (route) => false,
              );
            },);

          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UpiPaymentScreen(amount: grandTotal,type: widget.type,),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF620D),
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Confirm Order",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
