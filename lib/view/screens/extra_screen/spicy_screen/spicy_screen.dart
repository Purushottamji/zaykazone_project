import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';


class SpicyScreen extends StatefulWidget {
  const SpicyScreen({super.key});

  @override
  State<SpicyScreen> createState() => _SpicyScreenState();
}

class _SpicyScreenState extends State<SpicyScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> burgers = [
    {
      "name": "Burger Bistro",
      "restaurant": "Rose Garden",
      "image": "assets/images/berger.jpg",
      "price": 40,
      "rating": 4.7,
    },
    {
      "name": "Cheese Delight",
      "restaurant": "City Food Court",
      "image": "assets/images/cheese.jpg",
      "price": 35,
      "rating": 4.5,
    },
    {
      "name": "Spicy Special",
      "restaurant": "Downtown Deli",
      "image": "assets/images/french_fries.jpg",
      "price": 45,
      "rating": 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.arrow_back_ios_new_outlined,
                        color: Colors.white, size: width * 0.05),
                  ),
                  Text(
                    "Spicy Restaurant",
                    style: TextStyle(
                        fontSize: width * 0.05, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.more_horiz_outlined, size: width * 0.05),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
              child: Container(
                width: width,
                height: height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "asset/img_6.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Spicy Restaurant",
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  Text(
                    "Restaurant details typically include the cuisine, atmosphere and location to help customers decide where to eat.",
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                  SizedBox(height: height * 0.01),
                  SizedBox(
                    height: height * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        bool isSelected = index == selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: width * 0.03),
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04, vertical: height * 0.01),
                            decoration: BoxDecoration(
                              color: isSelected ? Color(0xffFF620D) : Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                "Burger",
                                style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey,
                                    fontSize: width * 0.04),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text("Burger (${burgers.length})",
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: burgers.length,
                padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                itemBuilder: (context, index) {
                  final burger = burgers[index];
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: height * 0.02),
                      height: height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                burger["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.04),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  burger["name"],
                                  style: TextStyle(
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  burger["restaurant"],
                                  style: TextStyle(fontSize: width * 0.035),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star_border_outlined,
                                        size: width * 0.045, color:Color(0xffFF620D)),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      burger["rating"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.04),
                                    ),
                                    SizedBox(width: width * 0.05),
                                    Icon(Icons.attach_money,
                                        size: width * 0.045, color: Color(0xffFF620D)),
                                    Text(
                                      burger["price"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.04),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
