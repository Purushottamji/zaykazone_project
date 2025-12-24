import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/model/order_modal/order_modal.dart';
import 'package:zaykazone/model/rating_model/rating_model.dart';
import 'package:zaykazone/view/screens/profile/rating_and_review.dart';
import '../../../controller/rating_provider/rating_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../../../services/rating_api_service/rating_api.dart';

class AddReviewScreen extends StatefulWidget {
  final String? productName;
  final RatingModel? reviewData;
  final OrderResult? orderData;
  const AddReviewScreen({super.key, this.productName, this.reviewData, this.orderData});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {

  @override
  void initState() {
    super.initState();
    RatingApi.storeUserId(context);
    Future.microtask(() {
      Provider.of<RatingProvider>(context,listen: false).productNameController.text=widget.productName!;
    },);
    if (widget.reviewData != null) {
      final provider =
      Provider.of<RatingProvider>(context, listen: false);

      provider.commentController.text =
          widget.reviewData!.experience ?? "";

      provider.productNameController.text =
          widget.reviewData!.productName ?? "";

      provider.ratingId = widget.reviewData!.id;
      provider.rating = widget.reviewData!.rating ?? 0;
    }
  }

  static const accentColor = Color(0xffFF620D);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RatingProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final userName = Provider
        .of<LoginProvider>(context)
        .userData?["name"];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Add Review"),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          /// 🌈 Background
          Container(
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
          ),

          /// 🧊 Glass Card
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    padding: EdgeInsets.all(w * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("Product Name"),
                          _glassTextField(
                            controller: provider.productNameController,
                            hint: "Enter product name",
                            validator: (v) =>
                                v!.isEmpty ? "Enter product name" : null,
                          ),

                          const SizedBox(height: 22),

                          _label("Rate your experience"),
                          const SizedBox(height: 6),
                          Row(
                            children: List.generate(5, (index) {
                              final pos = index + 1;
                              return IconButton(
                                onPressed: () {
                                  setState(() => provider.rating = pos.toDouble());
                                },
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: Icon(
                                    Icons.star,
                                    key: ValueKey(pos <= provider.rating),
                                    size: 30,
                                    color: pos <= provider.rating
                                        ? accentColor
                                        : Colors.white38,
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 14),

                          _label("Your Experience"),
                          _glassTextField(
                            controller: provider.commentController,
                            hint: "Write your experience...",
                            maxLines: 3,
                            validator: (v) =>
                                v!.isEmpty ? "Enter experience" : null,
                          ),

                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: provider.loading
                                  ? null
                                  : () async {
                                      if (provider.rating == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("Please give rating"),
                                          ),
                                        );
                                        return;
                                      }

                                      if (provider.formKey.currentState!.validate()) {
                                        setState(() => provider.loading = true);
                                        if (widget.reviewData == null) {
                                          await provider.addReview(
                                            userId: RatingApi.storeId,
                                            resId: widget.orderData!.resId,
                                            productName:
                                                provider.productNameController.text,
                                            rating: provider.rating,
                                            experience: provider.commentController.text, userName: userName,
                                          );
                                        } else {
                                          await provider.editReview(
                                              id: provider.ratingId!,
                                              productName: provider.productNameController
                                                  .text
                                                  .trim(),
                                              rating: provider.rating,
                                              experience: provider.commentController.text
                                                  .trim());
                                        }

                                        setState(() => provider.loading = false);

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                RestaurantRatingScreen(),
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 10,
                              ),
                              child: provider.loading
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "SUBMIT REVIEW",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔤 Label Widget
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 🧊 Glass TextField
  Widget _glassTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
