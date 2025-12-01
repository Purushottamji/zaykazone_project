import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/cart/cart_screen.dart';

class BurgerScreen extends StatefulWidget {
  final Map<String, dynamic> allFood;
  final String image;
  const BurgerScreen({super.key, required this.allFood, required this.image});

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
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xadff620d),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              widget.allFood["image"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05, vertical: height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_outlined,
                                      color: Colors.black87, size: width * 0.05),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.allFood["name"],
                            style: TextStyle(
                                fontSize: width * 0.05, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: width * 0.035,
                                child: Image.asset(widget.image),
                              ),
                              SizedBox(width: width * 0.03),
                              Text(
                                "Rose Garden",
                                style: TextStyle(fontSize: width * 0.035),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            children: [
                              Icon(Icons.star_border_outlined,
                                  size: width * 0.05, color: Color(0xffFF620D)),
                              SizedBox(width: width * 0.02),
                              Text(
                                "4.7",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: width * 0.05),
                              Icon(Icons.delivery_dining,
                                  size: width * 0.05, color: Color(0xffFF620D)),
                              SizedBox(width: width * 0.02),
                              Text(
                                "Free",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: width * 0.05),
                              Icon(Icons.timer,
                                  size: width * 0.05, color: Color(0xffFF620D)),
                              SizedBox(width: width * 0.02),
                              Text(
                                "20 min",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
                            style: TextStyle(fontSize: width * 0.04),
                          ),

                          SizedBox(height: height * 0.02),
                          Text(
                            "SIZE:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: width * 0.045),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            children: [
                              for (int i = 0; i < 3; i++)
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.03),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = i;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: width * 0.06,
                                      backgroundColor:
                                      selectedSize == i ? Color(0xffFF620D) : Colors.grey[300],
                                      child: Text(
                                        i == 0
                                            ? "10'"
                                            : i == 1
                                            ? "14'"
                                            : "16'",
                                        style: TextStyle(
                                            color: selectedSize == i
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),

                          SizedBox(height: height * 0.02),
                          Text(
                            "INGREDIENTS",
                            style: TextStyle(
                                fontSize: width * 0.045, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: height * 0.01),
                          SizedBox(
                            height: height * 0.08,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: width * 0.03),
                                  child: CircleAvatar(
                                    radius: width * 0.06,
                                    child: Icon(Icons.account_circle),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.deepOrange,offset: Offset(0, -5),blurRadius: 5)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "&32",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: width * 0.05),
                      ),
                      Container(
                        width: width * 0.3,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: width * 0.045,
                                child: Text("-",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            Text(
                              "$quantity",
                              style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() => quantity++);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: width * 0.045,
                                child: Text("+",style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF620D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.045),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
