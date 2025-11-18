import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff121223),
      ),
      backgroundColor: Color(0xff121223),

      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff2A2A39),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Image(
                        image: AssetImage("assets/images/img.png"),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pizza Calzone\nEuropean",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "₹64",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "14",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(0xff41414F),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(0xff41414F),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),
                    Container(
                      height: 35,width: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xffFF620D)),
                      child:IconButton(
                          onPressed: () {
                          }, icon: Icon(Icons.close,color: Colors.white,size: 20,)),

                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF620D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: screenHeight*0.40,
                      width: screenWidth*1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Text("DELIVERY ADDRESS"),
                                  Spacer(),
                                  Text(
                                    "EDIT",
                                    style: TextStyle(color: Color(0xffFF620D)),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "DELIVERY ADDRESS",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                children: [
                                  Text("TOTAL:96"),
                                  Spacer(),
                                  Text(
                                    "Breakdown >",
                                    style: TextStyle(color: Color(0xffFF620D)),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF620D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
                                },
                                child: Text(
                                  "PLACE ORDER",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "OpenButtonSheet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
