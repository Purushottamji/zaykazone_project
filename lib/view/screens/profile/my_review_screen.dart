// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/rating_provider/rating_provider.dart';
//
// class MyReviewsScreen extends StatefulWidget {
//   const MyReviewsScreen({super.key});
//
//   @override
//   State<MyReviewsScreen> createState() => _MyReviewsScreenState();
// }
//
// class _MyReviewsScreenState extends State<MyReviewsScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     int userId = 31;
//
//     Future.microtask(() {
//       if (!mounted) return;
//       Provider.of<RatingProvider>(context, listen: false)
//           .getRating(userId);   // ✔ FIXED
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<RatingProvider>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("My Reviews"),
//           backgroundColor: Color(0xffFF620D),
//         ),
//
//         body: provider.ratingList.isEmpty
//             ? Center(child: Text("No Reviews Found"))
//             : ListView.builder(
//           itemCount: provider.ratingList.length,
//           itemBuilder: (context, index) {
//             var review = provider.ratingList[index];
//
//             return Card(
//               margin: EdgeInsets.all(12),
//               child: Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Product: ${review.productName}"), // ✔ FIXED
//                     SizedBox(height: 5),
//
//                     Text("Rating: ${review.rating}"), // ✔ FIXED
//                     SizedBox(height: 5),
//
//                     Text("Experience: ${review.experience}"), // ✔ FIXED
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/rating_provider/rating_provider.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RatingProvider>(context, listen: false).getRating(31);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RatingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Reviews"),
        backgroundColor: Colors.orange,
      ),
      body: provider.loading
          ? Center(child: CircularProgressIndicator())
          : provider.ratingList.isEmpty
          ? Center(child: Text("No Reviews Found"))
          : ListView.builder(
        itemCount: provider.ratingList.length,
        itemBuilder: (context, index) {
          var review = provider.ratingList[index];

          // Dismissible widget for swipe-to-delete
          return Dismissible(
            key: Key(review.id.toString()),

            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),

            direction: DismissDirection.endToStart,

            onDismissed: (direction) async {
              // Delete from API & Provider
              await provider.deleteReview(review.id!);

              // Optional: show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Review deleted")),
              );
            },

            child: SizedBox(
              width: 500,
              child: Card(

                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product: ${review.productName}"),
                      Text("Rating: ${review.rating}"),
                      Text("Experience: ${review.experience}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
