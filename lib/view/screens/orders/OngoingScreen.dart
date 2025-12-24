import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';
import 'dart:ui';
import '../../../controller/order_provider/order_provider.dart';
import '../shimmer_screen/order_shimmer.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);

    if (provider.isPlacingOrder) {
      return const OrderShimmer();
    }

    final data = provider.orderData?.result ?? [];
    final ongoing = data.where((e) => e.quantity <= 1).toList();

    if (ongoing.isEmpty) {
      return const Center(
        child: Text(
          "No Ongoing Orders",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: ongoing.length,
      itemBuilder: (context, index) {
        final item = ongoing[index];

        final isCancelling =
            provider.cancelLoading[item.orderId] == true;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
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
                            color: Color(0xffFF620D),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 20, color: Colors.white30),

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
                              /// Name + Order ID
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.foodName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "#${item.orderId}",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "₹${item.totalPrice} | ${item.quantity} Items",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Row(
                                children: [
                                  /// TRACK ORDER
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrderScreen(),));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xffFF620D),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text("Track Order"),
                                  ),

                                  const SizedBox(width: 10),

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
                                    child: isCancelling
                                        ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child:
                                      CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xffFF620D),
                                      ),
                                    )
                                        : const Text(
                                      "Rate Now",
                                      style: TextStyle(
                                          color:
                                          Color(0xffFF620D)),
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
