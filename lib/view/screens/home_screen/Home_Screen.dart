import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/detail_screen/food_details_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allRestaurants = [
    {
      "name": "Rose Garden Restaurant",
      "category": "Burger - Chicken - Wings",
      "rating": 4.7,
      "time": "20 min",
      "delivery": "Free",
      "image": "assets/images/restaurant.jpg",
    },
    {
      "name": "Pizza Palace",
      "category": "Pizza - Italian - Fast Food",
      "rating": 4.5,
      "time": "25 min",
      "delivery": "Paid",
      "image": "assets/images/restaurant1.jpg",
    },
    {
      "name": "Biryani House",
      "category": "Indian - Biryani - Curry",
      "rating": 4.8,
      "time": "30 min",
      "delivery": "Free",
      "image": "assets/images/restaurant2.jpg",
    },
  ];

  List<Map<String, dynamic>> allFood = [
    {
      "name": "All",
      "image": "assets/images/restaurant.jpg",
      "color": Color(0xffFF620D),
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": Color(0xffefa67f),
    },
    {
      "name": "Berger",
      "image": "assets/images/berger.jpg",
      "color": Color(0xffefa67f),
    },
    {
      "name": "HotDog",
      "image": "assets/images/hotdog.jpg",
      "color": Color(0xffefa67f),
    },
    {
      "name": "Biryani",
      "image": "assets/images/biryani.jpg",
      "color": Color(0xffefa67f),
    },
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurants = List.from(allRestaurants);

    searchController.addListener(() {
      filterRestaurants(searchController.text);
    });
  }

  void filterRestaurants(String query) {
    final results = allRestaurants.where((item) {
      final name = item["name"].toLowerCase();
      final category = item["category"].toLowerCase();
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) || category.contains(searchLower);
    }).toList();

    setState(() => filteredRestaurants = results);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.filter_alt_off_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DELIVER TO",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text("ZaykaZone Lab Office", style: TextStyle(fontSize: 15)),
          ],
        ),
        backgroundColor: Color(0xffFF620D),
      ),

      body: ListView(
        children: [
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hey Rakesh, Good afternoon!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Dishes, restaurant",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          ListTile(
            title: Text(
              "All Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("See All"),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),

          SizedBox(
            height: height * 0.08,
            child: ListView.builder(
              itemCount: allFood.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = allFood[index];
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              FoodItemsListScreen(restaurant: allFood[index])));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: item["color"],
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(item["image"]),
                            ),
                            SizedBox(width: 5),
                            Text(item["name"]),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          ListTile(
            title: Text(
              "Open Restaurants",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("See All"),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),

          SizedBox(
            height: height * 0.6,
            child: filteredRestaurants.isEmpty
                ? Center(
              child: Text(
                "No Restaurants Found",
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: filteredRestaurants.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                var item = filteredRestaurants[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ⭐ IMAGE + CART ICON
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: height * 0.2,
                              width: double.infinity,
                              child: Image.asset(
                                item["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                print("Cart Icon Clicked");
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                Colors.white.withOpacity(0.8),
                                child: Icon(Icons.shopping_cart,
                                    color: Color(0xffFF620D)),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantDetailsScreen(
                                    restaurant: allRestaurants[index],
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          item["name"],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(item["category"]),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Icon(Icons.star, color: Color(0xffFF620D)),
                          Text("${item["rating"]}"),
                          SizedBox(width: 20),
                          Icon(Icons.delivery_dining,
                              color: Color(0xffFF620D)),
                          Text(" ${item["delivery"]}"),
                          SizedBox(width: 20),
                          Icon(Icons.watch_later_outlined,
                              color: Color(0xffFF620D)),
                          Text(" ${item["time"]}"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
