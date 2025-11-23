// import 'package:flutter/material.dart';
//
// class DetailScreen extends StatefulWidget {
//   final Map<String, dynamic> item;
//
//   const DetailScreen({super.key, required this.item});
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   int qty = 1;
//   String selectedSize = "14'";
//   bool isFav = false;
//
//   List<String> sizes = ["10'", "14'", "16'"];
//   List<String> ingredients = ["Cheese", "Tomato", "Chicken", "Olives", "Corn"];
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text("Details", style: TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//
//       body: Column(
//         children: [
//           // ---------- IMAGE & LIKE BUTTON ----------
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 40, left: 20, right: 20),
//                 height: height * 0.22,
//                 decoration: BoxDecoration(
//                   color: Colors.orange.shade200,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//
//               // FOOD IMAGE
//               Positioned(
//                 top: -10,
//                 left: width * 0.25,
//                 right: width * 0.25,
//                 child: Container(
//                   height: 160,
//                   child: Image.asset(widget.item["image"], fit: BoxFit.contain),
//                 ),
//               ),
//
//               // LIKE BUTTON
//               Positioned(
//                 right: 40,
//                 bottom: 15,
//                 child: GestureDetector(
//                   onTap: () => setState(() => isFav = !isFav),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       isFav ? Icons.favorite : Icons.favorite_border,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 20),
//
//           // ---------- RESTAURANT TAG ----------
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 20),
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Colors.black87,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 15,
//                       backgroundImage: AssetImage("asset/img_4.png"),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       widget.item["restaurant"],
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 15),
//
//           // ---------- TITLE & DESCRIPTION ----------
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.item["name"],
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   widget.item["desc"],
//                   style: TextStyle(fontSize: 14, color: Colors.black87),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 10),
//
//           // ---------- RATING - DELIVERY - FREE ----------
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Row(
//               children: [
//                 Icon(Icons.star, color: Colors.orange),
//                 SizedBox(width: 5),
//                 Text(widget.item["rating"].toString(),
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//
//                 SizedBox(width: 20),
//                 Icon(Icons.delivery_dining, color: Colors.orange),
//                 SizedBox(width: 5),
//                 Text("Free Delivery"),
//
//                 SizedBox(width: 20),
//                 Icon(Icons.access_time, color: Colors.orange),
//                 SizedBox(width: 5),
//                 Text("20 min"),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // ---------- SIZE SELECTION ----------
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Row(
//               children: [
//                 Text("SIZE:", style: TextStyle(fontSize: 16)),
//                 SizedBox(width: 15),
//                 ...sizes.map(
//                       (s) => GestureDetector(
//                     onTap: () => setState(() => selectedSize = s),
//                     child: Container(
//                       margin: EdgeInsets.only(right: 15),
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: selectedSize == s
//                             ? Colors.orange
//                             : Colors.grey.shade300,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         s,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color:
//                           selectedSize == s ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // ---------- INGREDIENT LIST ----------
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Text(
//               "INGREDIENTS",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//
//           SizedBox(
//             height: height * 0.12,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.only(left: 20),
//               itemCount: ingredients.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 12),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.orange.shade100,
//                         child: Icon(Icons.fastfood, color: Colors.orange),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         ingredients[index],
//                         style: TextStyle(fontSize: 12),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // ---------- PRICE & QUANTITY ----------
//           Spacer(),
//
//           Container(
//             height: 160,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 // PRICE + QTY
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "₹ ${widget.item["price"] * qty}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//
//                       // Quantity buttons
//                       Container(
//                         height: 40,
//                         width: 110,
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 if (qty > 1) setState(() => qty--);
//                               },
//                               icon: Icon(Icons.remove,
//                                   color: Colors.white, size: 18),
//                             ),
//                             Text("$qty",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold)),
//                             IconButton(
//                               onPressed: () => setState(() => qty++),
//                               icon: Icon(Icons.add,
//                                   color: Colors.white, size: 18),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 10),
//
//                 // ADD TO CART BUTTON
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     child: Text("ADD TO CART",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FoodItemsListScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const FoodItemsListScreen({super.key, required this.restaurant});

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

  List<String> categories = [
    "All",
    "Burgers",
    "Pizza",
    "Snacks",
    "Chicken"
  ];

  String selectedCategory = "All";


  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color(0xffFF620D),   // Status bar background color
          statusBarIconBrightness: Brightness.light, // White icons (for dark bg)
        ),
      );

      var height = MediaQuery.of(context).size.height;

    List filteredFoods = selectedCategory == "All"
        ? foods
        : foods.where((f) => f["category"] == selectedCategory).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.restaurant["name"],style: TextStyle(fontSize: 20),),
          backgroundColor:  Color(0xffFF620D),
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15,),
            child: CircleAvatar(backgroundColor: Colors.white,
              child: IconButton(onPressed: () {
                Navigator.pop(context);
                
              }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 20,)),),
          ),
        ),

        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String cat = categories[index];
                  bool isSelected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ?  Color(0xffFF620D) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
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

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  var item = filteredFoods[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            child: SizedBox(
                              width: 120,
                              height: 110,
                              child: Image.asset(item["image"], fit: BoxFit.cover),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "₹ ${item["price"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:  Color(0xffFF620D),
                                  ),
                                ),
                                SizedBox(height: 8),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:  Color(0xffFF620D),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

