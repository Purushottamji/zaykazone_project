import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: ListView(
                    children: [
                      notificationTile(
                        title: "Order Delivered",
                        message: "Your order #234 was delivered successfully.",
                        time: "10 mins ago",
                        icon: Icons.check_circle,
                      ),
                      notificationTile(
                        title: "New Offer!",
                        message: "Get 20% OFF on Pizza Hut orders.",
                        time: "1 hour ago",
                        icon: Icons.local_offer,
                      ),
                      notificationTile(
                        title: "Order Shipped",
                        message: "Your order is on the way!",
                        time: "2 hours ago",
                        icon: Icons.delivery_dining,
                      ),
                      notificationTile(
                        title: "Wallet Update",
                        message: "₹150 added to your wallet.",
                        time: "Yesterday",
                        icon: Icons.account_balance_wallet,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget notificationTile({
    required String title,
    required String message,
    required String time,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.orange.shade100,
            child: Icon(icon, color: Color(0xffFF620D), size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                SizedBox(height: 5.h),
                Text(
                  message,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
                ),
                SizedBox(height: 5.h),
                Text(
                  time,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
