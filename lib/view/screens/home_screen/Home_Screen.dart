import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';
import 'package:zaykazone/view/screens/detail_screen/food_details_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:zaykazone/view/screens/profile/restaurant_screen.dart';
import '../profile/r.dart';
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
    {"name": "All", "image": "assets/images/restaurant.jpg"},
    {"name": "Pizza", "image": "assets/images/pizza1.jpg"},
    {"name": "Berger", "image": "assets/images/berger.jpg"},
    {"name": "HotDog", "image": "assets/images/hotdog.jpg"},
    {"name": "Biryani", "image": "assets/images/biryani.jpg"},
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];
  bool isExpanded = false;

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
    var provider = Provider.of<RestaurantDetailsProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFF620D),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Delivery", style: TextStyle(fontSize: 18)),
              Text(
                "Halal lab Office",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              //snap: true,
              backgroundColor: Color(0xffFF620D),
              automaticallyImplyLeading: false,
              title: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search dishes, restaurants...",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([

                SizedBox(height: 10),

                // CATEGORY TITLE
                ListTile(
                  title: Text("All Categories",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("See All", style: TextStyle(fontSize: 13)),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => R()));
                  },
                ),

                // FOOD LIST
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allFood.length,
                    itemBuilder: (context, index) {
                      var item = allFood[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodItemsListScreen(restaurant: item),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 15),

                // RESTAURANT TITLE
                ListTile(
                  title: Text("Open Restaurants",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("See All", style: TextStyle(fontSize: 13)),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RestaurantScreen()),
                    );
                  },
                ),

                // RESTAURANT LIST API DATA
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.listProduct.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    var item = provider.listProduct[index];

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
                              child: Image.network(
                                "http://zaykazone-project-api.onrender.com/uploads/${item.image_url}",
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

                          SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RestaurantDetailsScreen(
                                      restaurant: allRestaurants[0]),
                                ),
                              );
                            },
                            child: Text(
                              "${item.name}",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFF620D)),
                            ),
                          ),

                          Text(
                            "${item.description}",
                            maxLines: isExpanded ? null : 2,
                            overflow: isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),

                          InkWell(
                            onTap: () =>
                                setState(() => isExpanded = !isExpanded),
                            child: Row(
                              children: [
                                Text(
                                  isExpanded ? "Show Less" : "Show More",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 5),

                          Text("${item.food_details}",
                              maxLines: 2, overflow: TextOverflow.ellipsis),

                          SizedBox(height: 5),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.red),
                              Text("${item.rating}"),
                              SizedBox(width: 15),

                              Icon(Icons.delivery_dining,
                                  color: Colors.red),
                              Text(" ${item.delivery_charge}"),
                              SizedBox(width: 15),

                              Icon(Icons.watch_later_outlined,
                                  color: Colors.red),
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
