import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> food = [
    {"name": "HotDog", "image": "assets/images/hotdog.jpg","prize":"90","quantity":1},
    {"name": "Pizza", "image": "assets/images/pizza1.jpg","prize":"85","quantity":1},
    {"name": "Berger", "image": "assets/images/berger.jpg","prize":"50","quantity":1},
  ];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),

      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            backgroundColor: Colors.white,
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 20,)),),
          
        ),
        title: const Text("Cart",style: TextStyle(fontSize: 20),),
        backgroundColor: const Color(0xffFF620D),
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: food.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(3, 3),blurRadius: 5,spreadRadius: 2)],
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                       food[index]["image"],
                        width: width * 0.18,
                        height: width * 0.18,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            food[index]["name"],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 5),

                           Text(
                            "₹${food[index]["prize"]}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                               Text("${food[index]["quantity"]}",
                                  style: TextStyle(color: Colors.black54)),

                              const Spacer(),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    food[index]["quantity"]--;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff41414F),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.remove, color: Colors.white, size: 18),
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    food[index]["quantity"]++;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff41414F),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.add, color: Colors.white, size: 18),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: width * 0.02),

                    InkWell(
                      onTap: () {
                        setState(() {
                          food.removeAt(index);
                        });
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: const Color(0xffFF620D),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.close,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          height: 170,
          width: 300,
          padding:  EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15)
            ),
            border: Border.all(
              color: Color(0xffFF620D),
              width: 1,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total price",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),
              ),

              SizedBox(height: 5),
              Text(
                "Free Delivery",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange,
                ),
              ),

              SizedBox(height: 5),
              Text(
                "₹${food[0]["prize"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  ElevatedButton(
                    onPressed: () {
                      _openBottomSheet(context, width, height);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF620D),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "CheckOut",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
      ],
      ),
    );
  }


  void _openBottomSheet(context, width, height) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),

      builder: (_) {
        return Container(
          height: height * 0.30,
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: const [
                  Text("DELIVERY ADDRESS",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("EDIT", style: TextStyle(color: Color(0xffFF620D))),
                ],
              ),

              const SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Delivery Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: const [
                  Text("TOTAL: ₹90",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("Breakdown >",
                      style: TextStyle(color: Color(0xffFF620D))),
                ],
              ),

             SizedBox(height: 15,),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF620D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PaymentScreen()));
                    },
                    child: const Text("PLACE ORDER",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
