import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';
import 'package:zaykazone/view/screens/detail_screen/food_details_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import 'package:zaykazone/view/screens/profile/restaurant_screen.dart';
import '../profile/r.dart';

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
    var provider=Provider.of<RestaurantDetailsProvider>(context);
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return
      SafeArea(child:Scaffold(appBar: AppBar(backgroundColor: Color(0xffFF620D),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: () {
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 20,)),),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Delivery",style: TextStyle(fontSize: 18),),
        Text(" Halal lab Office",style: TextStyle(fontSize: 18,color: Colors.white),),
      ],),
    ),
      body:
      CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
             snap: true,


            backgroundColor: Color(0xffFF620D),
            elevation: 2,
            automaticallyImplyLeading: false,
            title: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search dishes, restaurants...",
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),



          SliverList(
            delegate: SliverChildListDelegate(
              [

                SizedBox(height: 10),

                ListTile(
                  title: Text(
                    "All Categories",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => R()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("See All", style: TextStyle(fontSize: 13)),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  ),
                ),


                SizedBox(
                  height: 150,
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
                              builder: (context) =>
                                  FoodItemsListScreen(
                                    restaurant: allFood[index],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: 140,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: item["color"],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 8,),
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
                                SizedBox(height:4),
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

                ListTile(
                  title: Text(
                    "Open Restaurants",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RestaurantScreen()));
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
                            child: SizedBox(height: screenHeight *0.2,width: screenWidth *0.9,
                              child:
                              Image.network(
                                "http://10.115.48.10:3000/uploads/${item.image_url}",
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
                                  builder:
                                      (context) =>
                                      RestaurantDetailsScreen(
                                        restaurant: allRestaurants[index],
                                      ),
                                ),
                              );
                            },
                            child:
                            Text("${item.name}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Color(0xffFF620D) ),),
                          ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                    "${item.description}",
                    style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    ),
                    maxLines: isExpanded ? null :2,
                    overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                      SizedBox(height: 1),
                    GestureDetector(
                    onTap: () {
                    setState(() {
                    isExpanded = !isExpanded;
                    });
                    },
                    child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text(
                    isExpanded ? "Show Less" : "Show More",
                    style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.black,
                    )],),),],
                    ),

                    SizedBox(height: 5),
                          Text("${item.food_details}",style: TextStyle(color: Colors.black45), maxLines: isExpanded ? null : 2,
                            overflow:
                            isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,),
                          SizedBox(height: 1,),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.red),
                              Text("${item.rating}"),
                              SizedBox(width: 15),
                              Icon(Icons.delivery_dining, color: Colors.red),
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

              ],
            ),
          ),
        ],
      ),
    ));
  }
}
