import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../rating_api/rating_api.dart';
import '../rating_model/rating_model.dart';

class RatingProvider with ChangeNotifier {
  List<RatingModel> ratingList = [];
  bool loading = false;


  /// GET REVIEWS
  Future<void> getRating(int userId) async {
    loading = true;
    notifyListeners();

    ratingList = await RatingApi.getRatingDetails(userId) ?? [];

    loading = false;
    notifyListeners();
  }

  /// ADD REVIEW
  Future<void> addReview({
    required int userId,
    required int resId,
    required String productName,
    required double rating,
    required String experience,
  }) async {
    var ok = await RatingApi.addReview(
      userId: userId,
      res_id: resId,
      productName: productName,
      rating: rating,
      experience: experience,
    );

    if (ok != null) {
      Get.snackbar("Success", "AddRating successfully");
    } else {
      Get.snackbar("Failed", "Failed to add rating");
    }
  }

  /// DELETE REVIEW
  Future<void> deleteReview(int id) async {
    loading = true;
    notifyListeners();

    bool success = await RatingApi.deleteRating(id);

    loading = false;
    notifyListeners();

    if (success) {
      // Remove deleted item from list if exists
      ratingList.removeWhere((element) => element.id == id);
      Get.snackbar("Success", "Rating deleted successfully");
    } else {
      Get.snackbar("Failed", "Failed to delete rating");
    }
  }
}
