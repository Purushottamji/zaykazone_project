import 'package:flutter/material.dart';

class BurgerScreen extends StatefulWidget {
  const BurgerScreen({super.key});

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
                    // ------------------- IMAGE & HEADER -------------------
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
                              "asset/img_5.png",
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
                                backgroundColor: Colors.grey,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_outlined,
                                      color: Colors.white, size: width * 0.05),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // ------------------- RESTAURANT INFO -------------------
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Burger Bistro",
                            style: TextStyle(
                                fontSize: width * 0.05, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: width * 0.035,
                                child: Image.asset("asset/img_4.png"),
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

                          // ------------------- SIZE SELECTION -------------------
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

                          // ------------------- INGREDIENTS -------------------
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

            // ------------------- ADD TO CART SECTION -------------------
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Quantity selector
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
                          color: Colors.black,
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
                                radius: width * 0.045,
                                child: Text("-"),
                              ),
                            ),
                            Text(
                              "$quantity",
                              style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() => quantity++);
                              },
                              child: CircleAvatar(
                                radius: width * 0.045,
                                child: Text("+"),
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
                      onPressed: () {},
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
