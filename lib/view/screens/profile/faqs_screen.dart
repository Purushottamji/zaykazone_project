import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, dynamic>> faqList = [
    {
      "question": "How can I track my order?",
      "answer":
      "You can track your order in the 'Orders' section. Real-time updates will be shown there.",
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
      "We accept UPI, Debit/Credit Cards, Net Banking, and Cash on Delivery depending on your location.",
    },
    {
      "question": "How do I apply a coupon?",
      "answer":
      "Go to the 'Offers' section, choose a coupon, or enter a promo code at checkout.",
    },
    {
      "question": "What if my food arrives late?",
      "answer":
      "If your food is delayed, you can contact support or request compensation in the help center.",
    },
    {
      "question": "Can I cancel my order?",
      "answer":
      "Yes, you can cancel an order before the restaurant accepts it. After acceptance, cancellation may not be allowed.",
    },
  ];

  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(faqList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFF620D),
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
                    "FAQs",
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
                padding: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      faqList.length,
                          (index) => _buildFAQItem(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        collapsedShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        tilePadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
        childrenPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        title: Text(
          faqList[index]["question"],
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          isExpandedList[index]
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Color(0xffFF620D),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpandedList[index] = expanded;
          });
        },
        children: [
          Text(
            faqList[index]["answer"],
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
