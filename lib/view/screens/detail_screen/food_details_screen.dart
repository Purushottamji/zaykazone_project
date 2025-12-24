import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zaykazone/model/cart_modal/cart_modal.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';
import '../../../controller/cart_provider/cart_provider.dart';
import '../../../controller/food_detail_provider/food_detail_provider.dart';

class FoodItemsListScreen extends StatefulWidget {
  const FoodItemsListScreen({super.key});

  @override
  State<FoodItemsListScreen> createState() => _FoodItemsListScreenState();
}

class _FoodItemsListScreenState extends State<FoodItemsListScreen> {

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodDetailProvider>(context);

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
            _glassAppBar(context),

            Expanded(
              child: foodProvider.isLoading
                  ? _glassShimmer()
                  : foodProvider.filteredFoods.isEmpty
                      ? const Center(
                          child: Text(
                            "No food items found",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : _foodList(foodProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
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

  Widget _glassAppBar(BuildContext context) {
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
          decoration: BoxDecoration(
            color: const Color(0xffff620d).withOpacity(0.6),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.25)),
            ),
          ),
          child: Row(
            children: [
              _glassIcon(Icons.arrow_back_ios_new, () {
                Navigator.pop(context);
              }),
              const SizedBox(width: 16),
              const Text(
                "Food Items",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _foodList(FoodDetailProvider foodProvider) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: foodProvider.filteredFoods.length,
      itemBuilder: (context, index) {
        final item = foodProvider.filteredFoods[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BurgerScreen(allFood: item),));
                },
                child: Container(
                  width: 330,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.image ?? "",
                          width: 120,
                          height: 110,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 120,
                            height: 110,
                            color: Colors.black26,
                            child: const Icon(
                              Icons.fastfood,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.name ?? "Unknown",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "₹ ${item.price ?? 0}",
                                style: const TextStyle(
                                  color: Color(0xffFF620D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _glassButton(
                                    text: "ADD CART",
                                    color: const Color(0xffFF620D),
                                    onTap: () async {
                                      final newItem = CartModel(
                                        title: item.name ?? "",
                                        image: item.image ?? "",
                                        price: double.tryParse(
                                                item.price.toString()) ??
                                            0,
                                        quantity: 1, resId: item.restaurantId ?? 0,
                                      );
                                      await cartProvider.addToCart(newItem);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("${item.name} added to cart"),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _glassButton(
                                    text: "BUY",
                                    color: Colors.green,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(foodData: item,type: "buy",),));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _glassButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
