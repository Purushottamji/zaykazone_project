import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/Favourite_provider/Favourite_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavouritePro>().getFavourites();
    });
  }
  @override
  Widget build(BuildContext context) {
    final favPro = context.watch<FavouritePro>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("My Favourites"),
        centerTitle: true,
        backgroundColor: FavouriteScreen.accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
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
        child:favPro.isLoading ? const Center(
          child: CircularProgressIndicator(),
        ):
        favPro.items.isEmpty
            ? _emptyState()
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  kToolbarHeight + 46,
                  16,
                  16,
                ),
                itemCount: favPro.items.length,
                itemBuilder: (_, index) {
                  final food = favPro.items[index];
                  return _favouriteCard(context, favPro, food);
                },
              ),
      ),
    );
  }

  Widget _favouriteCard(
    BuildContext context,
    FavouritePro fav,
    dynamic food,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    food.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${food.price}",
                        style: const TextStyle(
                          color: FavouriteScreen.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () async{
                    if (isDeleting) return;

                    setState(() =>
                    isDeleting = true);

                    try {
                      await fav.removeFavourite(
                        food.favouriteId,
                      );

                      _showSnack(
                        "Removed from favourites ❤️",
                      );
                    } catch (e) {
                      _showSnack(
                        "Something went wrong",
                      );
                    }

                    setState(() =>
                    isDeleting = false);

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 80, color: Colors.white54),
          SizedBox(height: 12),
          Text(
            "No Favourite Items ❤️",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration:
        const Duration(seconds: 1),
      ),
    );
  }
}
