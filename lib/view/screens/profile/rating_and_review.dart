import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/rating_provider/rating_provider.dart';
import '../../../model/rating_model/rating_model.dart';
import 'add_review_screen.dart';

class RestaurantRatingScreen extends StatefulWidget {
  const RestaurantRatingScreen({super.key});

  static const accentColor = Color(0xffFF620D);

  @override
  State<RestaurantRatingScreen> createState() =>
      _RestaurantRatingScreenState();
}

class _RestaurantRatingScreenState extends State<RestaurantRatingScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RatingProvider>(context, listen: false).getRating();
    });
  }

  // ✅ Average rating calculation
  double _calculateAverageRating(List<RatingModel> ratings) {
    if (ratings.isEmpty) return 0.0;
    double total = ratings.fold(
      0.0,
          (sum, item) => sum + (item.rating ?? 0),
    );
    return total / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .of(context)
        .size
        .width;
    final provider = Provider.of<RatingProvider>(context);
    final avgRating = _calculateAverageRating(provider.ratingList);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Ratings & Reviews"),
        centerTitle: true,
        backgroundColor:
        RestaurantRatingScreen.accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(
          padding: EdgeInsets.all(w * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight + 30),

              // ⭐ SUMMARY CARD
              _glassCard(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          avgRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _StarRow(rating: avgRating),
                        const SizedBox(height: 6),
                        Text(
                          "${provider.ratingList.length} ratings",
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: _ratingBars()),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Customer Reviews",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // ✅ Animated review list
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: provider.loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : provider.ratingList.isEmpty
                    ? Center(
                      child: const Text(
                                        "No Reviews Found",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                    )
                    : Column(
                  key: ValueKey(
                      provider.ratingList.length),
                  children: provider.ratingList
                      .map(
                        (review) =>
                        _reviewTile(
                          review: review,
                          provider: provider,
                        ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: RestaurantRatingScreen.accentColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.rate_review),
        label: const Text("Add Review"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddReviewScreen(),
            ),
          );
        },
      ),
    );
  }

  // 🧊 GLASS CARD
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white24),
          ),
          child: child,
        ),
      ),
    );
  }

  // 📊 Rating bars (static UI preserved)
  Widget _ratingBars() {
    return Column(
      children: List.generate(5, (index) {
        final star = 5 - index;
        final value = [0.6, 0.2, 0.1, 0.05, 0.05][index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Text("$star",
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 6),
              const Icon(Icons.star,
                  size: 14,
                  color: RestaurantRatingScreen.accentColor),
              const SizedBox(width: 6),
              Expanded(
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white24,
                  color:
                  RestaurantRatingScreen.accentColor,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _reviewTile({
    required RatingModel review,
    required RatingProvider provider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Dismissible(
        key: ValueKey(review.id),

        // 👉 LEFT ➜ RIGHT (EDIT)
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.8),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(Icons.edit, color: Colors.white),
        ),

        // 👉 RIGHT ➜ LEFT (DELETE)
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),

        confirmDismiss: (direction) async {
          // ✏️ EDIT
          if (direction == DismissDirection.startToEnd) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddReviewScreen(reviewData: review),
              ),
            );
            return false;
          }

          // 🗑 DELETE
          if (direction == DismissDirection.endToStart) {
            return await showDialog<bool>(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: const Text("Delete Review"),
                    content:
                    const Text("Are you sure you want to delete this review?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
            );
          }
          return false;
        },

        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart) {
            await provider.deleteReview(review.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Review deleted")),
            );
          }
        },

        child: _glassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.user_name ?? "Anonymous",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              _StarRow(rating: review.rating ?? 0),

              const SizedBox(height: 6),

              Text(
                review.experience ?? "",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  final double rating;

  const _StarRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 16,
          color: index < rating
              ? const Color(0xffFF620D)
              : Colors.white30,
        );
      }),
    );
  }
}
