import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/view/screens/cart/cart_screen.dart';
import 'package:zaykazone/view/screens/profile/favourite_screen.dart';

import '../../../controller/Favourite_provider/Favourite_provider.dart';

import '../../../controller/cart_provider.dart';
import '../../../model/cart_modal/cart_modal.dart';

class BurgerScreen extends StatefulWidget {
  final Map<String,dynamic> allFood;
  const BurgerScreen({super.key, required this.allFood});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  int selectedSize = 1;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: width,
                          height: height * 0.30,
                          color: const Color(0xadff620d),
                          child: Image.network(
                            widget.allFood.image,
                            fit: BoxFit.cover,
                            errorBuilder: (c, o, s) =>
                            const Icon(Icons.broken_image, size: 60),
                          ),
                        ),


                        Positioned(
                          top: 15,
                          left: 15,
                          right: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Consumer<FavouriteProvider>(
                                  builder: (context, fav, _) => IconButton(
                                    icon: Icon(
                                      fav.isFavourite(widget.allFood)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      fav.toggleFavourite(widget.allFood);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen(),));
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),


                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            widget.allFood.name,
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),


                          Row(
                            children: [
                              // CircleAvatar(
                              //   radius: width * 0.035,
                              //   child: Image.asset("assets/burger.png"),
                              // ),
                              // SizedBox(width: width * 0.03),
                             //Text(widget.allFoo),
                            ],
                          ),

                          SizedBox(height: height * 0.02),


                          Text(
                            widget.allFood.description,
                            style: TextStyle(fontSize: width * 0.04),
                          ),

                          SizedBox(height: height * 0.03),


                          Text(
                            "SIZE",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),


                          Row(
                            children: List.generate(3, (i) {
                              return Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: GestureDetector(
                                  onTap: () => setState(() => selectedSize = i),
                                  child: CircleAvatar(
                                    radius: width * 0.06,
                                    backgroundColor: selectedSize == i
                                        ? Colors.deepOrange
                                        : Colors.grey[300],
                                    child: Text(
                                      i == 0
                                          ? "10'"
                                          : i == 1
                                          ? "14'"
                                          : "16'",
                                      style: TextStyle(
                                        color: selectedSize == i
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 15,),
                          Row(children: [
                            Icon(Icons.star,color: Colors.orange,),
                            SizedBox(width: 6,),
                            Text(widget.allFood.rating)

                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.deepOrange, blurRadius: 5, offset: Offset(0, -5))
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${widget.allFood.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.055,
                        ),
                      ),


                      Row(
                        children: [
                          _qtyButton("-", () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          }),
                          SizedBox(width: width * 0.05),
                          Text(
                            "$quantity",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: width * 0.05),
                          _qtyButton("+", () {
                            setState(() => quantity++);
                          }),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.015),


                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MyCartScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "ADD TO CART",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
