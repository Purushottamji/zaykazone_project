// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../rating_api/rating_api.dart';
// import '../rating_model/rating_model.dart';
//
// class RatingProvider with ChangeNotifier {
//   List<RatingModel> ratingList = [];
//   bool loading = false;
//
//   List<Map> showData = [
//     {
//       "name": "Sonu",
//       "age": 22,
//     }
//   ];
//
//
//
//   /// GET REVIEWS
//   Future<void> getRating() async {
//     loading = true;
//     notifyListeners();
//
//     ratingList = await RatingApi.getRatingDetails() ?? [];
//
//     loading = false;
//     notifyListeners();
//   }
//
//   /// ADD REVIEW
//   Future<void> addReview({
//     required int userId,
//     required int resId,
//     required String productName,
//     required double rating,
//     required String experience,
//   }) async {
//     var ok = await RatingApi.addReview(
//       userId: userId,
//       res_id: resId,
//       productName: productName,
//       rating: rating,
//       experience: experience,
//     );
//
//     if (ok != null) {
//       Get.snackbar("Success", "AddRating successfully");
//     } else {
//       Get.snackbar("Failed", "Failed to add rating");
//     }
//   }
//
//   /// DELETE REVIEW
//   Future<void> deleteReview(int id) async {
//     loading = true;
//     notifyListeners();
//
//     bool success = await RatingApi.deleteRating(id);
//
//     loading = false;
//     notifyListeners();
//
//     if (success) {
//       // Remove deleted item from list if exists
//       ratingList.removeWhere((element) => element.id == id);
//       Get.snackbar("Success", "Rating deleted successfully");
//     } else {
//       Get.snackbar("Failed", "Failed to delete rating");
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../rating_api/rating_api.dart';
import '../rating_model/rating_model.dart';

class RatingProvider with ChangeNotifier {
  List<RatingModel> ratingList = [];
  bool loading = false;

  /// GET REVIEWS
  Future<void> getRating() async {
    loading = true;
    notifyListeners();

    ratingList = await RatingApi.getRatingDetails() ?? [];

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
      resId: resId,
      productName: productName,
      rating: rating,
      experience: experience,
    );

    if (ok != null) {
      Get.snackbar("Success", "Rating added");
    } else {
      Get.snackbar("Failed", "Failed to add rating");
    }
  }

  /// DELETE REVIEW
  Future<void> deleteReview(int id) async {
    loading = true;
    notifyListeners();

    bool success = await RatingApi.deleteRating(id);

    if (success) {
      ratingList.removeWhere((e) => e.id == id);
      Get.snackbar("Success", "Rating deleted");
    } else {
      Get.snackbar("Failed", "Delete failed");
    }

    loading = false;
    notifyListeners();
  }
}
