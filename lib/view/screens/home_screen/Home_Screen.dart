import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/on_boarding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.filter_alt_off_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DELIVER TO",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text("Halal Lab Office", style: TextStyle(fontSize: 15)),
          ],
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              if (value == "logout") {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("onBoardingStatus", false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                );
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: "logout", child: Text("LogOut")),
                ],
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Hey Rakesh,",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 10),
                    child: Text("Good afternoon!"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
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
                contentPadding: EdgeInsets.only(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  right: 15,
                ),
                title: Text(
                  "All Categories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: SizedBox(
                  width: 67,
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            Container(
                              width: 85,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 4,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.fire_extinguisher_rounded),
                              ),
                            ),
                            Positioned(top: 13, left: 58, child: Text("All")),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // open restaurant
              ListTile(
                contentPadding: EdgeInsets.only(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  right: 15,
                ),
                title: Text(
                  "Open Restaurants",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: SizedBox(
                  width: 67,
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.5,
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              height: height * 0.2,
                              color: Colors.red,
                              child: Image.asset(
                                "asset/img.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rose Garden Restaurant",
                              style: TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text("Burger - Chicken - Riche - Wings"),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star_border, color: Colors.orange),
                            Text(
                              "4.7",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(Icons.picture_as_pdf, color: Colors.orange),
                            Text(
                              " free",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                              " 20 min",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
