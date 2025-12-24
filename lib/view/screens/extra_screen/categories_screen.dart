import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> allCategories = [
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    }, {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    }, {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
    {
      "name": "Pizza",
      "image": "assets/images/pizza1.jpg",
      "color": "deepOrangeAccent.shade100",
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFF620D), // STATUS BAR BG WHITE
        statusBarIconBrightness: Brightness.dark, // ICON COLOR BLACK
      ),
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          title: Text(
            "Categories",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: Color(0xffFF620D),
        ),
        backgroundColor: Colors.deepOrangeAccent.shade100,
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.10),
            Container(
              width: screenWidth * 1,
              height: screenHeight * 0.7772,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
                child: GridView.builder(
                  itemCount: allCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Column(children: [
                      CircleAvatar(radius: 30,backgroundImage: AssetImage(allCategories[index]["image"]),),
                      Text(allCategories[index]["name"])
                    ]);
                  },
                ),

                // Column(
                //   spacing: 25,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Pizza")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Burger")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Drinks")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Fries")]),
                //       ],
                //     ),   Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Pizza")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Burger")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Drinks")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Fries")]),
                //       ],
                //     ),   Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Pizza")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Burger")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Drinks")]),
                //         Column(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xffefa67f)), Text("Fries")]),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
