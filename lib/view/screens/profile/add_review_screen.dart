// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';
// // import 'package:zaykazone/rating_provider/rating_provider.dart';
// // import 'package:zaykazone/view/screens/profile/my_review_screen.dart';
// //
// // class AddReviewScreen extends StatefulWidget {
// //   const AddReviewScreen({super.key});
// //
// //   @override
// //   State<AddReviewScreen> createState() => _AddReviewScreenState();
// // }
// //
// // class _AddReviewScreenState extends State<AddReviewScreen> {
// //   double rating = 0;
// //   final commentController = TextEditingController();
// //   final formKey = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var provider=Provider.of<RatingProvider>(context);
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.orange,
// //         body: Column(
// //           children: [
// //             SizedBox(height: 20.h),
// //             Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 20.w),
// //               child: Row(
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () => Navigator.pop(context),
// //                     child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
// //                   ),
// //                   SizedBox(width: 15.w),
// //                   Text(
// //                     "Add Review",
// //                     style: TextStyle(
// //                       fontSize: 20.sp,
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(height: 20.h),
// //
// //             Expanded(
// //               child: Container(
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(20.r),
// //                     topRight: Radius.circular(20.r),
// //                   ),
// //                 ),
// //                 child: SingleChildScrollView(
// //                   padding: EdgeInsets.all(20.w),
// //                   child: Form(
// //                     key: formKey,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           "Rate your experience",
// //                           style: TextStyle(
// //                             fontSize: 18.sp,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                         SizedBox(height: 15.h),
// //                         Row(
// //                           children: List.generate(
// //                             5,
// //                                 (index) {
// //                               final pos = index + 1;
// //                               return GestureDetector(
// //                                 onTap: () {
// //                                   setState(() {
// //                                     rating = pos.toDouble();
// //                                   });
// //                                 },
// //                                 child: Icon(
// //                                   Icons.star,
// //                                   size: 32.sp,
// //                                   color: pos <= rating
// //                                       ? Color(0xffFF620D)
// //                                       : Colors.grey.shade300,
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //
// //                         SizedBox(height: 30.h),
// //                         Text(
// //                           "Write your review",
// //                           style: TextStyle(
// //                             fontSize: 14.sp,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         SizedBox(height: 10.h),
// //                         TextFormField(
// //                           controller: commentController,
// //                           maxLines: 5,
// //                           decoration: InputDecoration(
// //                             hintText: "Tell others about your experience...",
// //                             border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(12.r),
// //                             ),
// //                           ),
// //                           validator: (value) {
// //                             if (value == null || value.isEmpty) {
// //                               return "Please write something";
// //                             }
// //                             return null;
// //                           },
// //                         ),
// //
// //                         SizedBox(height: 30.h),
// //                         Center(
// //                           child: ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Color(0xffFF620D),
// //                               padding: EdgeInsets.symmetric(
// //                                 horizontal: 100.w,
// //                                 vertical: 14.h,
// //                               ),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(12.r),
// //                               ),
// //                             ),
// //                             onPressed: () {
// //                               if (rating == 0) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(
// //                                       content: Text("Please give a rating")),
// //                                 );
// //                                 return;
// //                               }
// //                               if (formKey.currentState!.validate()) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(
// //                                       content: Text("Review submitted")),
// //                                 );
// //                                 Navigator.push(context, MaterialPageRoute(builder: (context) => MyReviewsScreen(),));
// //                               }
// //                             },
// //                             child: Text(
// //                               "SUBMIT",
// //                               style: TextStyle(
// //                                 fontSize: 16.sp,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                             ),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/rating_provider/rating_provider.dart';
// import 'package:zaykazone/view/screens/profile/my_review_screen.dart';
//
// class AddReviewScreen extends StatefulWidget {
//   const AddReviewScreen({super.key});
//
//   @override
//   State<AddReviewScreen> createState() => _AddReviewScreenState();
// }
//
// class _AddReviewScreenState extends State<AddReviewScreen> {
//   @override
//   void initState() {
//     Provider.of<RatingProvider>(context,listen: false).getRating(10);
//
//     super.initState();
//   }
//   double rating = 0;
//   final commentController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     var provider=Provider.of<RatingProvider>(context);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.orange,
//         body: Column(
//           children: [
//             SizedBox(height: 20.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
//                   ),
//                   SizedBox(width: 15.w),
//                   Text(
//                     "Add Review",
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.r),
//                     topRight: Radius.circular(20.r),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(20.w),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Rate your experience",
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         Row(
//                           children: List.generate(
//                             5,
//                                 (index) {
//                               final pos = index + 1;
//                               return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     rating = pos.toDouble();
//                                   });
//                                 },
//                                 child: Icon(
//                                   Icons.star,
//                                   size: 32.sp,
//                                   color: pos <= rating
//                                       ? Color(0xffFF620D)
//                                       : Colors.grey.shade300,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//
//                         SizedBox(height: 30.h),
//                         Text(
//                           "Write your review",
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           controller: commentController,
//                           maxLines: 5,
//                           decoration: InputDecoration(
//                             hintText: "Tell others about your experience...",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.r),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please write something";
//                             }
//                             return null;
//                           },
//                         ),
//
//                         SizedBox(height: 30.h),
//                         Center(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xffFF620D),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 100.w,
//                                 vertical: 14.h,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (rating == 0) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Please give a rating")),
//                                 );
//                                 return;
//                               }
//                               if (formKey.currentState!.validate()) {
//
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Review submitted")),
//
//                                 );
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => MyReviewsScreen(),));
//                                 provider.getRating(10);
//                               }
//                             },
//                             child: Text(
//                               "SUBMIT",
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_review_screen.dart';
import 'package:zaykazone/rating_provider/rating_provider.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
   double rating = 0;
  final commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RatingProvider>(context);

    int userId = 31;
    String productName = "Pizza";

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Review"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rate your experience", style: TextStyle(fontSize: 18)),

              Row(
                children: List.generate(5, (index) {
                  int pos = index + 1;
                  return IconButton(
                    onPressed: () {
                      setState(() => rating = pos.toDouble());
                    },
                    icon: Icon(
                      Icons.star,
                      color: pos <= rating ? Colors.orange : Colors.grey,
                    ),
                  );
                }),
              ),

              SizedBox(height: 10),
              Text("Rate your Product", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              TextFormField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write your review...",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                v!.isEmpty ? "Please write something" : null,
              ),

              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange),
                  onPressed: () async {
                    if (rating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please give rating")),
                      );
                      return;
                    }

                    if (formKey.currentState!.validate()) {
                      await provider.addReview(
                        userId: 31,
                        productName: productName,
                        rating: rating,
                        experience: commentController.text,
                        resId: 4,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyReviewsScreen(),
                        ),
                      );
                    }
                  },
                  child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
