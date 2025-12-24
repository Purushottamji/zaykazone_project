import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import 'dart:ui';
import '../../../controller/restaurant_details_provider/restaurant_details_provider.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final Map<int, bool> expandedMap = {};

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<RestaurantDetailsProvider>(
        context,
        listen: false,
      ).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantDetailsProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
              child: provider.allRestaurants.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFF620D),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.allRestaurants.length,
                itemBuilder: (context, index) {
                  final item = provider.allRestaurants[index];
                  final isExpanded =
                      expandedMap[index] ?? false;

                  return Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20),
                    child: _glassRestaurantCard(
                      context,
                      item,
                      isExpanded,
                          () {
                        setState(() {
                          expandedMap[index] = !isExpanded;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
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
            color: Color(0xffff620d).withOpacity(0.60),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),
          child: Row(
            children: [
              _glassIcon(
                Icons.arrow_back_ios_new,
                    () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              const Text(
                "All Restaurants",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🍽 Glass Restaurant Card
  Widget _glassRestaurantCard(
      BuildContext context,
      dynamic item,
      bool isExpanded,
      VoidCallback toggle,
      ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20),
            border:
            Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailsScreen(
                          restaurant: item,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    item.image_url ?? "",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      item.name ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// Description
                    Text(
                      item.description ?? "",
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    GestureDetector(
                      onTap: toggle,
                      child: Row(
                        children: [
                          Text(
                            isExpanded ? "Show Less" : "Show More",
                            style: const TextStyle(
                              color: Color(0xffFF620D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xffFF620D),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Info Row
                    Row(
                      children: [
                        _info(Icons.star, item.rating.toString()),
                        _info(Icons.delivery_dining,
                            item.delivery_charge.toString()),
                        _info(Icons.watch_later_outlined,
                            item.delivery_time ?? ""),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ℹ️ Info Item
  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xffFF620D), size: 18),
          const SizedBox(width: 4),
          Text(
            text,
            style:
            const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// 🔘 Glass Icon Button
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
