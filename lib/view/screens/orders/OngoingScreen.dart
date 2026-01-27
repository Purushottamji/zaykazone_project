import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';
import 'dart:ui';
import '../../../controller/order_provider/order_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../shimmer_screen/order_shimmer.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({super.key});

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId= context.read<LoginProvider>().userData?["id"];
      if(userId!=null){
        context.read<OrderProvider>().fetchOrders(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);

    if (provider.isPlacingOrder) {
      return const OrderShimmer();
    }

    final data = provider.orderData?.result ?? [];
    final ongoing = data.where((e) =>
    e.status == "Pending" ||
        e.status == "Placed" ||
        e.status == "Preparing"
    ).toList();


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
        final canCancel = item.status == "Pending" ||
            item.status == "Placed" ||
            item.status == "Preparing";

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
                            color: item.status == "Pending" ||
                                item.status == "Placed" ||
                                item.status == "Preparing"?Color(0xff2fb60a):Color(0xffFF620D),
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

                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrderScreen(order: item,),));
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
                        if (canCancel)
                          OutlinedButton(
                            onPressed: isCancelling
                                ? null
                                : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Cancel Order"),
                                  content: const Text(
                                      "Are you sure you want to cancel this order?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        "Yes, Cancel",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await provider.cancelOrder(
                                    item.orderId, context);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isCancelling
                                ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.red,
                              ),
                            )
                                : const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
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
                          child: const Text(
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
            ),
          ),
        );
      },
    );
  }
}
