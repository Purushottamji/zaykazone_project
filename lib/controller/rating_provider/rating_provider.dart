

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/rating_model/rating_model.dart';
import '../../services/rating_api_service/rating_api.dart';

class RatingProvider with ChangeNotifier {
  List<RatingModel> ratingList = [];
  bool loading = false;
  int? ratingId;
  double rating = 0;

  final commentController = TextEditingController();
   TextEditingController productNameController=TextEditingController();

  final formKey = GlobalKey<FormState>();


  Future<void> getRating() async {
    loading = true;
    notifyListeners();

    ratingList = await RatingApi.getRatingDetails() ?? [];

    loading = false;
    notifyListeners();
  }

  Future<void> addReview({
    required int userId,
    required int resId,
    required String productName,
    required double rating,
    required String experience,
    required String userName
  }) async {
    var ok = await RatingApi.addReview(
      userId: userId,
      resId: resId,
      productName: productName,
      rating: rating,
      experience: experience, userName: userName,
    );

    if (ok != null) {
      Get.snackbar("Success", "Rating added");
    } else {
      Get.snackbar("Failed", "Failed to add rating");
    }
  }

  Future<void> editReview({
    required int id,
    required String productName,
    required double rating,
    required String experience,
  }) async {
    var ok = await RatingApi.editReview(
      id: id,
      productName: productName,
      rating: rating,
      experience: experience,
    );
    if (ok != null) {
      Get.snackbar("Success", "Rating updated");
    } else {
      Get.snackbar("Failed", "Failed to update rating");
    }
  }

  shareData(int index){
    commentController.text=ratingList[index].experience!;
    productNameController.text=ratingList[index].productName!;
    ratingId=ratingList[index].id;
  }

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


  @override
  void dispose() {
    commentController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
