// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SearchProductScreen extends StatefulWidget {
//   const SearchProductScreen({super.key});
//
//   @override
//   State<SearchProductScreen> createState() => _SearchProductScreenState();
// }
//
// class _SearchProductScreenState extends State<SearchProductScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffFF620D),
//         elevation: 0,
//        automaticallyImplyLeading: false,
//         title: const Text(
//           "Search",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//       ),
//
//
//
//
//       body: ListView(
//         children: [
//
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: "Search Dishes, Restaurants",
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//
//           sectionTitle("Recent Keywords"),
//           recentKeywords(width),
//
//           const SizedBox(height: 10),
//
//           sectionTitle("Suggested Restaurants"),
//           suggestedRestaurants(width, height),
//
//           const SizedBox(height: 10),
//
//           sectionTitle("Popular Fast Food"),
//
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: 5,
//             itemBuilder: (context, index) {
//               return fastFoodRow(width, height);
//             },
//           ),
//
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget sectionTitle(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, top: 10),
//       child: Text(
//         text,
//         style: const TextStyle(
//             fontSize: 17, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget recentKeywords(double width) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, top: 8),
//       child: SizedBox(
//         height: 40,
//         child: ListView.builder(
//           itemCount: 8,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: const EdgeInsets.only(right: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 border: Border.all(color: Colors.grey, width: 1.5),
//               ),
//               child: const Center(child: Text("Burger")),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget suggestedRestaurants(double width, double height) {
//     return SizedBox(
//       height: height * 0.42,
//       child: ListView.separated(
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 3,
//         separatorBuilder: (context, index) =>
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Divider(thickness: 1),
//         ),
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 20, top: 10),
//                 width: width * 0.18,
//                 height: height * 0.09,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: Colors.grey,
//                 ),
//                 child: Image.asset("assets/images/restaurant1.jpg", fit: BoxFit.cover),
//               ),
//               const SizedBox(width: 15),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text("Pansi Restaurant",
//                       style:
//                       TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Color(0xffFF620D), size: 18),
//                       SizedBox(width: 5),
//                       Text("4.7",
//                           style:
//                           TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget fastFoodRow(double width, double height) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//       child: Row(
//         children: [
//           Expanded(child: fastFoodCard(width, height)),
//           Expanded(child: fastFoodCard(width, height)),
//         ],
//       ),
//     );
//   }
//
//   Widget fastFoodCard(double width, double height) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       height: height * 0.28,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.grey.shade200),
//       child: Column(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               "assets/images/pizza1.jpg",
//               width: width,
//               height: height * 0.18,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 15),
//           const Text(
//             "European Pizza",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             "Uttora Coffee House",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           )
//         ],
//       ),
//     );
//   }
// }

//
//
// class SearchProductScreen extends StatefulWidget {
//   const SearchProductScreen({super.key});
//
//   @override
//   State<SearchProductScreen> createState() => _SearchProductScreenState();
// }
//
// class _SearchProductScreenState extends State<SearchProductScreen> {
//
//   // 🔥 Your product list or restaurant list
//   List<String> allItems = [
//     "Burger",
//     "Pizza",
//     "Sandwich",
//     "Momos",
//     "Chicken Roll",
//     "Pasta",
//     "Biryani",
//     "Fried Rice",
//     "Cold Coffee",
//     "French Fries",
//   ];
//
//   // Search result list
//   List<String> filteredList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredList = allItems; // Default full list
//   }
//
//   // 🔍 Search Function
//   void searchItem(String query) {
//     setState(() {
//       filteredList = allItems
//           .where((item) =>
//           item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text("Search"),
//       ),
//
//       body: Column(
//         children: [
//
//           // 🔍 Search Box
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               onChanged: searchItem,    // <--- IMPORTANT
//               decoration: InputDecoration(
//                 hintText: "Search Food...",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//
//           // 📌 Search Results
//           Expanded(
//             child: filteredList.isEmpty
//                 ? Center(
//               child: Text(
//                 "No results found",
//                 style:
//                 TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             )
//                 : ListView.builder(
//               itemCount: filteredList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.fastfood, color: Colors.orange),
//                   title: Text(filteredList[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_provider/restaurant_details_provider.dart';
import '../../../model/users/restaurant_details_modal.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  // 🔥 Filtered list (state ke andar)
  List<RestaurantDetailsModal> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    var provider =
    Provider.of<RestaurantDetailsProvider>(context, listen: false);

    // Default full list load
    filteredRestaurants = List.from(provider.listProduct);
  }

  // 🔍 Search Function
  void filterRestaurants(String query) {
    var provider =
    Provider.of<RestaurantDetailsProvider>(context, listen: false);

    if (query.isEmpty) {
      setState(() {
        filteredRestaurants = List.from(provider.listProduct);
      });
      return;
    }

    final searchLower = query.toLowerCase();

    final results = provider.listProduct.where((item) {
      final name = item.name?.toLowerCase() ?? "";
      final address = item.address?.toLowerCase() ?? "";
      return name.contains(searchLower) || address.contains(searchLower);
    }).toList();

    setState(() {
      filteredRestaurants = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF620D),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      body: ListView(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              onChanged: filterRestaurants, // <-- IMPORTANT
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Dishes, Restaurants",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          sectionTitle("Recent Keywords"),
          recentKeywords(width),

          const SizedBox(height: 10),

          sectionTitle("Suggested Restaurants"),
          suggestedRestaurants(width, height), // <-- Now filtered

          const SizedBox(height: 10),

          sectionTitle("Popular Fast Food"),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return fastFoodRow(width, height);
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget recentKeywords(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey, width: 1.5),
              ),
              child: const Center(child: Text("Burger")),
            );
          },
        ),
      ),
    );
  }

  // ⭐ Suggested Restaurants (Now filtered list)
  Widget suggestedRestaurants(double width, double height) {
    return SizedBox(
      height: height * 0.42,
      child: filteredRestaurants.isEmpty
          ? const Center(
        child: Text(
          "No Restaurants Found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredRestaurants.length,
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(thickness: 1),
        ),
        itemBuilder: (context, index) {
          var restaurant = filteredRestaurants[index];

          return Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                width: width * 0.18,
                height: height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey,
                ),
                child: restaurant.image_url != null
                    ? Image.network(
                  "https://zaykazone-project-api.onrender.com/uploads/user_pic/${restaurant.image_url}",
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.restaurant),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? "",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(Icons.star,
                          color: Color(0xffFF620D), size: 18),
                      SizedBox(width: 5),
                      Text(
                        "4.7",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget fastFoodRow(double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(child: fastFoodCard(width, height)),
          Expanded(child: fastFoodCard(width, height)),
        ],
      ),
    );
  }

  Widget fastFoodCard(double width, double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height * 0.28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/pizza1.jpg",
              width: width,
              height: height * 0.18,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "European Pizza",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Uttora Coffee House",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
