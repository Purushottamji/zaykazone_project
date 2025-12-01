import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';
import 'package:zaykazone/view/screens/cart/cart_screen.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:zaykazone/view/screens/spicy_screen/spicy_screen.dart';

import '../detail_screen/food_details_screen.dart';
import '../detail_screen/restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  Map<int, bool> expandedMap = {};

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
    {"name": "All", "image": "assets/images/restaurant.jpg"},
    {"name": "Pizza", "image": "assets/images/pizza1.jpg"},
    {"name": "Berger", "image": "assets/images/berger.jpg"},
    {"name": "HotDog", "image": "assets/images/hotdog.jpg"},
    {"name": "Biryani", "image": "assets/images/biryani.jpg"},
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];
  bool isExpanded = false;

  void filterRestaurants(String query) {
    final results =
    allRestaurants.where((item) {
      final name = item["name"].toLowerCase();
      final category = item["category"].toLowerCase();
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) || category.contains(searchLower);
    }).toList();

    setState(() => filteredRestaurants = results);
  }

  @override
  void initState() {
    super.initState();
    filteredRestaurants = List.from(allRestaurants);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFF620D),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Future.microtask(() {
      Provider.of<RestaurantDetailsProvider>(
        context,
        listen: false,
      ).getProduct();
    });
    searchController.addListener(() {
      filterRestaurants(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RestaurantDetailsProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xffFF620D),
              automaticallyImplyLeading: false,
              pinned: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery", style: TextStyle(fontSize: 18)),
                  Text(
                    "Halal Lab Office",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      top: 10,
                      bottom: 10
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      hintText: "Search dishes, restaurants...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                ListTile(
                  title: Text(
                    "All Categories",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("See All", style: TextStyle(fontSize: 13)),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allFood.length,
                    itemBuilder: (context, index) {
                      var item = allFood[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                  BurgerScreen(allFood: allFood[index], image: allRestaurants[0]["image"],),
                            ),
                          );
                        },
                        child: Card(
                          color: Color(0x94f3420c),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                SizedBox(height: 8),
                                Container(
                                  height: 105,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(item["image"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item["name"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 5),
                ListTile(
                  title: Text(
                    "Open Restaurants",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("See All", style: TextStyle(fontSize: 13)),
                        Icon(Icons.arrow_forward_ios, size: 15),
                      ],
                    ),
                  ),
                ),

                provider.listProduct.isEmpty
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator(backgroundColor: Color(0xffFF620D),)),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.listProduct.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    var item = provider.listProduct[index];
                    bool isExpanded = expandedMap[index] ?? false;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.9,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => RestaurantDetailsScreen(
                                        restaurant:
                                        provider.listProduct[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  "https://zaykazone-project-restaurant_detail_api.onrender.com/uploads/${item.image_url}",
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (c, o, s) => Icon(
                                    Icons.broken_image,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            provider.listProduct[index].name ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF620D),
                            ),
                          ),

                          Text(
                            provider.listProduct[index].description ?? "",
                            maxLines: isExpanded ? null : 2,
                            overflow:
                            isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              setState(() {
                                expandedMap[index] = !isExpanded;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  isExpanded ? "Show Less" : "Show More",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange),
                              Text(" ${item.rating}"),
                              SizedBox(width: 15),
                              Icon(
                                Icons.delivery_dining,
                                color: Colors.orange,
                              ),
                              Text(" ${item.delivery_charge}"),
                              SizedBox(width: 15),
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.orange,
                              ),
                              Text(" ${item.delivery_time}"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
