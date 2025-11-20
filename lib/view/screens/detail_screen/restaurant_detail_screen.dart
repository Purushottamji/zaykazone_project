import 'package:flutter/material.dart';
import 'food_details_screen.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.32,
                    width: double.infinity,
                    child: Image.asset(
                      restaurant["image"],
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 40,
                    left: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant["name"],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),

                    Text(
                      restaurant["category"],
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),

                    SizedBox(height: 15),

                    Row(
                      children: [
                        Icon(Icons.star, color:  Color(0xffFF620D)),
                        SizedBox(width: 5),
                        Text("${restaurant["rating"]}", style: TextStyle(fontSize: 16)),

                        SizedBox(width: 20),
                        Icon(Icons.watch_later_outlined, color:  Color(0xffFF620D)),
                        SizedBox(width: 5),
                        Text(restaurant["time"], style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 8),
                    Text(
                      "Experience delicious and freshly cooked meals. Our chefs prepare the best dishes using top-quality ingredients.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                    ),

                    SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF620D),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FoodItemsListScreen(restaurant: restaurant),
                            ),
                          );
                        },
                        child: Text(
                          "View Menu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
