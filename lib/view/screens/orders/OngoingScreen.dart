
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/order_provider/order_provider.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrderProvider>(context);

    var data = provider.orderData?.result ?? [];
    var ongoing = data.where((e) => e.quantity > 1).toList();

    if (ongoing.isEmpty) {
      return Center(child: Text("No ongoing orders"));
    }

    return ListView.builder(
      itemCount: ongoing.length,
      itemBuilder: (context, index) {
        var item = ongoing[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6),
            ],
          ),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children:[
                  Text("Food",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text(
                    "Ongoing",
                    style: TextStyle(
                        color: Color(0xffFF620D),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const Divider(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade300,
                      child: Image.asset(
                        "assets/images/pizza1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.foodName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "#162432",
                              style: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      SizedBox(height: 5),

                         Text(
                          "₹${item.totalPrice} | ${item.quantity} Items",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),

                       SizedBox(height: 15),


                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                backgroundColor: Color(0xffFF620D),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("TrackOrder"),
                            ),

                            SizedBox(width: 10),

                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                side: const BorderSide(color: Color(0xffFF620D)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Rate Now",
                                style: TextStyle(color: Color(0xffFF620D)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
