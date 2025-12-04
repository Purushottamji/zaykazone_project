import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/Favourite_provider/Favourite_provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavouriteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Favourite Items"), backgroundColor: Colors.deepOrange),
      body: fav.items.isEmpty
          ? Center(child: Text("No Favourite Items"))
          : ListView.builder(
        itemCount: fav.items.length,
        itemBuilder: (context, index) {
          final food = fav.items[index];
          return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12), // image ke liye radius
                    child: Image.network(
                      food.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  title: Text(
                    food.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "₹${food.price}",
                    style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      fav.items.removeAt(fav.items.indexOf(food));
                      fav.notifyListeners();
                    },
                  ),
                ),
              ),
            );

        },
      ),
    );
  }
}
