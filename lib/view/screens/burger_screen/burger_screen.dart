import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/favourite_pro/favourite_pro.dart';
import '../../../controller/cart_provider/cart_provider.dart';
import '../../../model/cart_modal/cart_modal.dart';
import '../../../model/food_model/food_model.dart';

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

  @override
  void initState() {
    super.initState();
    totalPrice = double.parse(widget.allFood.price);
  }

  @override
  Widget build(BuildContext context) {
    final favPro = context.watch<FavouritePro>();
    final cartPro = context.read<CartProvider>();

    final isFav = favPro.isFavourite(widget.allFood.id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.allFood.image,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: isFavLoading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child:
                        CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        if (isFavLoading) return;

                        setState(() => isFavLoading = true);

                        try {
                          final fav = favPro.getFavouriteByFoodId(
                              widget.allFood.id);

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
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.allFood.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Text(widget.allFood.restaurantName),

                    const SizedBox(height: 12),
                    Text(widget.allFood.description),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.orange),
                        const SizedBox(width: 6),
                        Text(widget.allFood.rating),
                      ],
                    ),

                    const Spacer(),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            _qtyButton("-", () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  totalPrice =
                                      double.parse(widget.allFood.price) *
                                          quantity;
                                });
                              }
                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              child: Text(
                                "$quantity",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _qtyButton("+", () {
                              setState(() {
                                quantity++;
                                totalPrice =
                                    double.parse(widget.allFood.price) *
                                        quantity;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.deepOrange,
                        ),
                        onPressed: () async {
                          final cartItem = CartModel(
                            title: widget.allFood.name,
                            image: widget.allFood.image,
                            price: double.parse(widget.allFood.price),
                            quantity: quantity,
                          );

                          await cartPro.addToCart(cartItem);

                          _showSnack("Added to cart 🛒");
                        },
                        child: const Text(
                          "ADD TO CART",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _qtyButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.deepOrange,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18),
        ),
      ),
    );
  }
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
