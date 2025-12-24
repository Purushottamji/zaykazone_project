import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:shimmer/shimmer.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';
import '../../../controller/order_provider/order_provider.dart';
import '../../../controller/place_order_address_provider/place_order_address_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

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
              child: isLoading
                  ? _glassShimmer()
                  : provider.cartList.isEmpty
                  ? const Center(
                child: Text(
                  "My cart is empty",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  return _glassCartItem(provider, provider.cartList[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0,left: 15,right: 15),
              child: _glassCheckoutBar(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffFF620D).withOpacity(0.60),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),
          child: const Text(
            "My Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  Widget _glassShimmer() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) =>
          Shimmer.fromColors(
            baseColor: Colors.white24,
            highlightColor: Colors.white38,
            child: Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
    );
  }

  Widget _glassCartItem(CartProvider provider, item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              border: Border.all(
                color: const Color(0xffFF620D).withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(
                          height: 80,
                          width: 80,
                          color: Colors.grey,
                          child: const Icon(Icons.broken_image),
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${item.price}",
                        style: const TextStyle(
                            color: Color(0xffFF620D),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _quantityControl(provider, item),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => provider.removeItem(item.id!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _quantityControl(CartProvider provider, item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: const Color(0xffFF620D).withOpacity(0.8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                if (item.quantity > 1) {
                  provider.updateQuantity(item.id!, item.quantity - 1);
                }
              },
            ),
            Text(
              "${item.quantity}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () =>
                  provider.updateQuantity(item.id!, item.quantity + 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCheckoutBar(CartProvider provider) {
    if (provider.cartList.isEmpty) return const SizedBox.shrink();

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(15),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "₹${provider.totalAmount.toInt()}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF620D),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PaymentScreen(type: "cart",)),
                  );
                },
                child: const Text("Checkout",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
