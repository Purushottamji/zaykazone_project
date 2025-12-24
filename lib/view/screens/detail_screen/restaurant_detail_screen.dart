import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/restaurant_details_model/restaurant_details_modal.dart';
import '../../../controller/food_detail_provider/food_detail_provider.dart';
import 'food_details_screen.dart';
import 'dart:ui';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantDetailsModal restaurant;
  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: height * 0.32,
                      width: double.infinity,
                      child: Image.network(
                        widget.restaurant.image_url ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 15,
                      left: 15,
                      child: _glassIcon(
                        Icons.arrow_back_ios_new,
                            () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restaurant.name ?? "",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                _info(Icons.star,
                                    widget.restaurant.rating.toString()),
                                _info(Icons.delivery_dining,
                                    widget.restaurant.delivery_charge
                                        .toString()),
                                _info(Icons.watch_later_outlined,
                                    widget.restaurant.delivery_time ?? ""),
                              ],
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.restaurant.description ?? "",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.restaurant.address ?? "",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xffFF620D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  final provider =
                                  Provider.of<FoodDetailProvider>(context, listen: false);

                                  provider.setRestaurant(widget.restaurant.id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                      const FoodItemsListScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "VIEW MENU",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xffFF620D)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
