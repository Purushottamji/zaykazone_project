//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/model/cart_modal/cart_modal.dart';
//
// import '../../../controller/cart_provider/cart_provider.dart';
//
// class FoodItemsListScreen extends StatefulWidget {
//   const FoodItemsListScreen({super.key});
//
//   @override
//   State<FoodItemsListScreen> createState() => _FoodItemsListScreenState();
// }
//
// class _FoodItemsListScreenState extends State<FoodItemsListScreen> {
//   List<Map<String, dynamic>> foods = [
//     {
//       "name": "Chicken Burger",
//       "price": 120,
//       "category": "Burgers",
//       "image": "assets/images/checken_burger.jpg"
//     },
//     {
//       "name": "Veg Supreme Pizza",
//       "price": 250,
//       "category": "Pizza",
//       "image": "assets/images/pizza1.jpg"
//     },
//     {
//       "name": "Grilled Sandwich",
//       "price": 80,
//       "category": "Snacks",
//       "image": "assets/images/sandwich.jpg"
//     },
//     {
//       "name": "Chicken Wings",
//       "price": 180,
//       "category": "Chicken",
//       "image": "assets/images/chicken_wigs.jpg"
//     }
//   ];
//
//   List<String> categories = ["All", "Burgers", "Pizza", "Snacks", "Chicken"];
//
//   String selectedCategory = "All";
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: Color(0xffFF620D),
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//
//     var height = MediaQuery.of(context).size.height;
//
//     List filteredFoods = selectedCategory == "All" ? foods : foods.where((f) => f["category"] == selectedCategory).toList();
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Food Items", style: TextStyle(fontSize: 20)),
//           backgroundColor: Color(0xffFF620D),
//           foregroundColor: Colors.white,
//         ),
//         body: Column(
//           children: [
//
//             SizedBox(
//               height: 60,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   String cat = categories[index];
//                   bool isSelected = selectedCategory == cat;
//
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 12),
//                     child: GestureDetector(
//                       onTap: () => setState(() => selectedCategory = cat),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color:
//                               isSelected ? Color(0xffFF620D) : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         child: Center(
//                           child: Text(
//                             cat,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.black87,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 itemCount: filteredFoods?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   var item = filteredFoods![index];
//
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.only(bottom: 15),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Row(
//                       children: [
//                         // IMAGE
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: SizedBox(
//                               width: 120,
//                               height: 110,
//                               child:
//                                   Image.asset(item["image"], fit: BoxFit.cover),
//                             ),
//                           ),
//                         ),
//
//                         // DETAILS
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item["name"],
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   "₹ ${item["price"]}",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xffFF620D),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SizedBox(
//                                       width: 90,
//                                       child: TextButton(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Color(0xffFF620D),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10)),
//                                         ),
//                                         onPressed: () async {
//                                           final cartProvider = Provider.of<CartProvider>(context,listen: false);
//                                           final newItem = CartModel(
//                                             title: item["name"],
//                                             image: item["image"],
//                                             price: double.parse(
//                                                 item["price"].toString()),
//                                             quantity: 1,
//                                           );
//                                           await cartProvider.addToCart(newItem);
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                                 content: Text(
//                                                     "${item["name"]} added to cart")),
//                                           );
//                                         },
//                                         child: Text("ADD CART",
//                                             style: TextStyle(color: Colors.white)),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 90,
//                                       child: TextButton(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.green,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10)),
//                                         ),
//                                         onPressed: () async {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                                 content: Text(
//                                                     "Call RazorPay For Buying this item")),
//                                           );
//                                         },
//                                         child: Text("Buy Now",
//                                             style: TextStyle(color: Colors.white)),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/cart_modal/cart_modal.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';

class FoodItemsListScreen extends StatefulWidget {
  const FoodItemsListScreen({super.key});

  @override
  State<FoodItemsListScreen> createState() => _FoodItemsListScreenState();
}

class _FoodItemsListScreenState extends State<FoodItemsListScreen> {
  List<Map<String, dynamic>> foods = [
    {
      "name": "Chicken Burger",
      "price": 120,
      "category": "Burgers",
      "image": "assets/images/checken_burger.jpg"
    },
    {
      "name": "Veg Supreme Pizza",
      "price": 250,
      "category": "Pizza",
      "image": "assets/images/pizza1.jpg"
    },
    {
      "name": "Grilled Sandwich",
      "price": 80,
      "category": "Snacks",
      "image": "assets/images/sandwich.jpg"
    },
    {
      "name": "Chicken Wings",
      "price": 180,
      "category": "Chicken",
      "image": "assets/images/chicken_wigs.jpg"
    }
  ];

  List<String> categories = ["All", "Burgers", "Pizza", "Snacks", "Chicken"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFF620D),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List filteredFoods = selectedCategory == "All"
        ? foods
        : foods.where((f) => f["category"] == selectedCategory).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Items", style: TextStyle(fontSize: 20)),
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [

            // CATEGORY LIST
            SizedBox(
              height: height * 0.08,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String cat = categories[index];
                  bool isSelected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffFF620D)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color:
                              isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // FOOD LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  var item = filteredFoods[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [

                        // IMAGE
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: width * 0.30,
                              height: height * 0.14,
                              child: Image.asset(
                                item["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // DETAILS
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "₹ ${item["price"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffFF620D),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // ✅ IMPROVED BUTTONS
                                Row(
                                  children: [

                                    // ADD CART
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color(0xffFF620D),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          final cartProvider =
                                          Provider.of<CartProvider>(
                                              context,
                                              listen: false);

                                          final newItem = CartModel(
                                            title: item["name"],
                                            image: item["image"],
                                            price: double.parse(
                                                item["price"].toString()),
                                            quantity: 1,
                                          );

                                          await cartProvider
                                              .addToCart(newItem);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "${item["name"]} added to cart"),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "ADD CART",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    // BUY NOW
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),

                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Call RazorPay For Buying this item"),

                                            ),

                                          );
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
                                        },

                                        child: const Text(
                                          "BUY NOW",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
