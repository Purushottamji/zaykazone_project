import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> myReviews = [
    {
      "restaurant": "Burger House",
      "review": "Amazing burgers! Loved the taste.",
      "rating": 4.5,
      "date": "10 Nov 2025"
    },
    {
      "restaurant": "Pizza Studio",
      "review": "Cheese burst was awesome!",
      "rating": 5.0,
      "date": "02 Nov 2025"
    },
    {
      "restaurant": "Punjabi Tadka",
      "review": "Good food but delayed delivery.",
      "rating": 3.5,
      "date": "25 Oct 2025"
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List filteredReviews = myReviews.where((r) {
      return r["restaurant"]
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          r["review"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Reviews"),
          backgroundColor: Color(0xffFF620D),
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search your reviews...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),

            Expanded(
              child: filteredReviews.isEmpty
                  ? const Center(
                child: Text(
                  "No Reviews Found",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: filteredReviews.length,
                itemBuilder: (context, index) {
                  var review = filteredReviews[index];

                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review["restaurant"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                review["date"],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          RatingBarIndicator(
                            rating: review["rating"],
                            itemCount: 5,
                            itemSize: 22,
                            itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Color(0xffFF620D)),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            review["review"],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
