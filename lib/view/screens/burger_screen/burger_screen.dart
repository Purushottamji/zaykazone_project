import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';
import 'dart:ui';
import '../../../controller/Favourite_provider/Favourite_provider.dart';

import '../../../controller/cart_provider/cart_provider.dart';
import '../../../model/cart_modal/cart_modal.dart';

class BurgerScreen extends StatefulWidget {
  final FoodModel allFood;
  const BurgerScreen({super.key, required this.allFood});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  int quantity = 1;
  late double totalPrice;
  bool isFavLoading = false;
  int selectedSize = 1;

  @override
  void initState() {
    super.initState();
    totalPrice = double.parse(widget.allFood.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final favPro = context.watch<FavouritePro>();
    final isFav = favPro.isFavourite(widget.allFood.id);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.network(
            widget.allFood.image,
            height: width * 0.9,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 80),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(28)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28)),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.allFood.name,
                            style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                NetworkImage(widget.allFood.image),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.allFood.restaurantName,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Text(
                            widget.allFood.description,
                            style: const TextStyle(
                                color: Colors.white70, height: 1.4),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "SIZE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: List.generate(3, (i) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => selectedSize = i),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedSize == i
                                        ? const Color(0xffFF620D)
                                        : Colors.white24,
                                  ),
                                  child: Text(
                                    i == 0
                                        ? "10'"
                                        : i == 1
                                        ? "14'"
                                        : "16'",
                                    style: TextStyle(
                                        color: selectedSize == i
                                            ? Colors.white
                                            : Colors.white70),
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange),
                              const SizedBox(width: 6),
                              Text(widget.allFood.rating,
                                  style: const TextStyle(
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _glassIcon(
                    Icons.arrow_back_ios_new,
                        color: Color(0xffff620d),
                        () => Navigator.pop(context),
                  ),
              /// ❤️ Favourite
              _glassIcon(
                isFav
                    ? Icons.favorite
                    : Icons.favorite_border,
                    () async {
                  if (isFavLoading) return;

                  setState(() => isFavLoading = true);
                  try {
                    final fav =
                    favPro.getFavouriteByFoodId(widget.allFood.id);

                    if (fav != null) {
                      await favPro
                          .removeFavourite(fav.favouriteId);
                      _showSnack("Removed from favourites ❤️");
                    } else {
                      await favPro.addFavourite(
                        id: widget.allFood.id,
                        name: widget.allFood.name,
                        image: widget.allFood.image,
                        price: widget.allFood.price,
                      );
                      _showSnack("Added to favourites ❤️");
                    }
                  } catch (e) {
                    _showSnack("Please login to use favourites");
                  }

                  setState(() => isFavLoading = false);
                },
                color: Colors.red,
              ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: _glassBottomBar(context),
    );
  }

  Widget _glassBottomBar(BuildContext context) {
    final cartProvider =
    Provider.of<CartProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 💰 Price + Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _qtyButton("-", () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                            totalPrice =
                                double.parse(widget.allFood.price.toString()) *
                                    quantity;
                          });
                        }
                      }),
                      const SizedBox(width: 12),
                      Text("$quantity",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(width: 12),
                      _qtyButton("+", () {
                        setState(() {
                          quantity++;
                          totalPrice =
                              double.parse(widget.allFood.price.toString()) *
                                  quantity;
                        });
                      }),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// 🛒 Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF620D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () async {
                        final newItem = CartModel(
                          title: widget.allFood.name,
                          image: widget.allFood.image,
                          price: double.parse(
                              widget.allFood.price.toString()),
                          quantity: quantity, resId: widget.allFood.restaurantId,
                        );
                        await cartProvider.addToCart(newItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${widget.allFood.name} added to cart")),
                        );
                      },
                      child: const Text("ADD TO CART"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(foodData: widget.allFood,type: "buy_more",totalPrice: totalPrice,quantity: quantity,),));
                      },
                      child: const Text("BUY NOW"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon, VoidCallback onTap,
      {Color color = Colors.black}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
        ),
      ),
    );
  }

  Widget _qtyButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: const Color(0xffFF620D),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontSize: 18)),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 1)),
    );
  }
}

