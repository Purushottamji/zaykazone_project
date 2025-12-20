import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';
import '../../../controller/Favourite_provider/Favourite_provider.dart';
import '../../../controller/cart_provider/cart_provider.dart';
import '../../../model/cart_modal/cart_modal.dart';

class BurgerScreen extends StatefulWidget {
  final FoodModel allFood;
  const BurgerScreen({super.key, required this.allFood});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  int selectedSize = 1;
  int quantity = 1;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = double.parse(widget.allFood.price.toString());
  }

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
                            errorBuilder: (c, o, s) => Icon(
                              Icons.broken_image,
                              size: width * 0.15,
                            ),
                          ),
                        ),

                        Positioned(
                          top: height * 0.02,
                          left: width * 0.04,
                          right: width * 0.04,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: width * 0.05,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: width * 0.045,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              CircleAvatar(
                                radius: width * 0.05,
                                backgroundColor: Colors.white,
                                child: Consumer<FavouriteProvider>(
                                  builder: (context, fav, _) => IconButton(
                                    icon: Icon(
                                      fav.isFavourite(widget.allFood)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: width * 0.05,
                                    ),
                                    onPressed: () {
                                      fav.toggleFavourite(widget.allFood);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${widget.allFood.name} added in favourite list"),
                                        ),
                                      );
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

                          SizedBox(height: height * 0.015),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: width * 0.035,
                                backgroundImage:
                                NetworkImage(widget.allFood.image),
                              ),
                              SizedBox(width: width * 0.03),
                              Text(
                                widget.allFood.restaurantName,
                                style:
                                TextStyle(fontSize: width * 0.04),
                              ),
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

                          SizedBox(height: height * 0.015),

                          Row(
                            children: List.generate(3, (i) {
                              return Padding(
                                padding:
                                EdgeInsets.only(right: width * 0.03),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedSize = i),
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
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(height: height * 0.02),

                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: width * 0.06,
                              ),
                              SizedBox(width: width * 0.015),
                              Text(
                                widget.allFood.rating,
                                style:
                                TextStyle(fontSize: width * 0.04),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// BOTTOM BAR
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange,
                    blurRadius: 5,
                    offset: Offset(0, -5),
                  )
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.055,
                        ),
                      ),
                      Row(
                        children: [
                          _qtyButton("-", width, onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                                totalPrice = double.parse(
                                    widget.allFood.price.toString()) *
                                    quantity;
                              });
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
                          _qtyButton("+", width, onTap: () {
                            setState(() {
                              quantity++;
                              totalPrice = double.parse(
                                  widget.allFood.price.toString()) *
                                  quantity;
                            });
                          }),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.42,
                        height: height * 0.06,
                        child: ElevatedButton(
                          onPressed: () async {
                            final cartProvider =
                            Provider.of<CartProvider>(context,
                                listen: false);
                            final data = widget.allFood;

                            final newItem = CartModel(
                              title: data.name,
                              image: data.image,
                              price: double.parse(data.price.toString()),
                              quantity: quantity,
                            );

                            await cartProvider.addToCart(newItem);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text("${data.name} added to cart"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.045,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.42,
                        height: height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            final data = widget.allFood;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "For Buying ${data.name} Call RazorPay"),
                              ),
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.045,
                            ),
                          ),
                        ),
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
  }

  Widget _qtyButton(String text, double width,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: width * 0.045,
        backgroundColor: Colors.deepOrange,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.05,
          ),
        ),
      ),
    );
  }
}
