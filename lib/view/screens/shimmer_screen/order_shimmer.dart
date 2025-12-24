import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.all(14),
          child: Shimmer.fromColors(
            baseColor: Colors.white12,
            highlightColor: Colors.white24,
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        );
      },
    );
  }
}
