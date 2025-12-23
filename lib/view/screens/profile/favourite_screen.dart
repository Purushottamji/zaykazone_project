import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/favourite_pro/favourite_pro.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

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
      appBar: AppBar(
        title: const Text("My Favourites"),
        centerTitle: true,
      ),

      body: favPro.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : favPro.items.isEmpty
          ? const Center(
        child: Text(
          "No favourites found ❤️",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: favPro.items.length,
        itemBuilder: (context, index) {
          final item = favPro.items[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 2,
            child: ListTile(
              leading: ClipRRect(
                borderRadius:
                BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) =>
                  const Icon(
                    Icons.image_not_supported,
                  ),
                ),
              ),

              title: Text(
                item.name,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
              ),

              subtitle:
              Text("₹${item.price}"),

              trailing: isDeleting
                  ? const SizedBox(
                width: 24,
                height: 24,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () async {
                  if (isDeleting) return;

                  setState(() =>
                  isDeleting = true);

                  try {
                    await favPro
                        .removeFavourite(
                      item.favouriteId,
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
            ),
          );
        },
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
