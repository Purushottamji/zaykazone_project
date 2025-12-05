import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/food_detail_provider/food_detail_provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';
import 'package:zaykazone/model/users/restaurant_details_modal.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import '../detail_screen/restaurant_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  Map<int, bool> expandedMap = {};

  bool isExpanded = false;


  @override
  void initState() {
    super.initState();
    Provider.of<FoodDetailProvider>(context,listen: false).fetchFood();

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
      final query = searchController.text;

      Provider.of<FoodDetailProvider>(context, listen: false)
          .searchFood(query);

      Provider.of<RestaurantDetailsProvider>(context, listen: false)
          .searchRestaurants(query);
    });


  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RestaurantDetailsProvider>(context);
    var foodProvider = Provider.of<FoodDetailProvider>(context);
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
                SizedBox(height: 10),
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodProvider.filteredFoods.length,
                      itemBuilder: (context, index) {
                        var item = foodProvider.filteredFoods[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BurgerScreen(allFood: item),
                              ),
                            );
                          },

                          child: Card(
                            color: Color(0x94f3420c),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: SizedBox(
                              width: 130,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        item.image,
                                        height: 105,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    SizedBox(height: 6),
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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

                provider.filteredRestaurants.isEmpty &&
                    foodProvider.filteredFoods.isEmpty
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "No Results Found",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.filteredRestaurants.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    var item = provider.filteredRestaurants[index];
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
                                        provider.filteredRestaurants[index],
                                      ),
                                    ),
                                  );
                                },
                                child:
                                Image.network(
                                  item.image_url!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (c, o, s) => Icon(
                                    Icons.broken_image,
                                    size:60,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF620D),
                            ),
                          ),

                          Text(
                            item.description ?? "",
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

                          SizedBox(height: 5),

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