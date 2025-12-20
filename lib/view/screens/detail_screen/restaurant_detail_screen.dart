import 'package:flutter/material.dart';
import 'package:zaykazone/model/restaurant_details_model/restaurant_details_modal.dart';
import 'food_details_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantDetailsModal restaurant;
  const RestaurantDetailsScreen({super.key, required this.restaurant});
  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    height: height * 0.30,
                    width: double.infinity,
                    child:
                   Image(image: NetworkImage(widget.restaurant.image_url!),fit: BoxFit.cover,)
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
                      widget.restaurant.name ?? "",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffFF620D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height*0.01),
                    Row(
                      children: [
                        Icon(Icons.star, color:  Color(0xffFF620D)),
                        SizedBox(width: 5),
                        Text("${widget.restaurant.rating}", style: TextStyle(fontSize: 16)),

                        SizedBox(width: 20),
                        Icon(Icons.delivery_dining, color:  Color(0xffFF620D)),
                        SizedBox(width: 5),
                        Text("${widget.restaurant.delivery_charge}", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 20),
                        Icon(Icons.watch_later_outlined, color:  Color(0xffFF620D)),
                        SizedBox(width: 5),
                        Text(widget.restaurant.delivery_time ??"", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height*0.02),
                    Text(
                      widget.restaurant.description ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: height*0.01),
                    Text(
                      "Location",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: height*0.02),
                    Text(
                      widget.restaurant.address ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: height*0.03),

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
                              builder: (context) => FoodItemsListScreen(),
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
