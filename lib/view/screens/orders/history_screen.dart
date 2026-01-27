import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/order_history_provider/order_history_provider.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';

import '../../../controller/food_detail_provider/food_detail_provider.dart';
import '../../../controller/order_provider/order_provider.dart';
import '../edit_profile/edit_profile.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/order_provider/order_provider.dart';
import '../edit_profile/edit_profile.dart';
import '../profile/add_review_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final foodProvider = Provider.of<FoodDetailProvider>(context);
    final orders = provider.orderData?.result ?? [];
    final historyOrders = orders.where((e) =>
    e.status == "Delivered" || e.status == "Cancelled"
    ).toList();


    if (historyOrders.isEmpty) {
      return const Center(
        child: Text(
          "No Completed Orders",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: historyOrders.length,
      itemBuilder: (context, index) {
        final item = historyOrders[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xffFF620D).withOpacity(0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Food",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Text(
                          item.status,
                          style: TextStyle(
                            color: item.status == "Delivered"
                                ? Colors.green
                                : Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                    const Divider(height: 24, color: Colors.white24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.network(
                              item.image ?? "https://cdn-icons-png.flaticon.com/512/9417/9417083.png",
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.foodName,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                   Text(
                                    "#${item.orderId}",
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "₹${item.totalPrice} | ${item.quantity} Items",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70),
                              ),

                              const SizedBox(height: 14),

                              Wrap(
                                spacing: 10,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(productName: item.foodName,orderData: item,),));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Color(0xffFF620D)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Rate Now",
                                      style: TextStyle(
                                          color: Color(0xffFF620D)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xffFF620D),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Re-order",
                                      style:
                                      TextStyle(color: Colors.white),
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
              ),
            ),
          ),
        );
      },
    );
  }
}

