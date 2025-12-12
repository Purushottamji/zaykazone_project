


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/rating_api/rating_api.dart';
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
      Provider.of<RatingProvider>(context, listen: false).getRating();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RatingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Reviews"),
        backgroundColor: Color((0xffFF620D)),
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
              await provider.deleteReview(review.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Review deleted")),
              );
            },

            child: SizedBox(
              width: 500,

              child: Card(
                color: Colors.orange.shade100,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product: ${review.productName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("Experience: ${review.experience}"),
                      // Text("Rating: ${review.rating}"),
                      Row(
                        children: List.generate(5, (index) {
                          double rate = review.rating ?? 0.0;
                          return Icon(
                            Icons.star,
                            color: index < rate ? Colors.orange : Colors.grey,
                          );
                        }),
                      ),

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
