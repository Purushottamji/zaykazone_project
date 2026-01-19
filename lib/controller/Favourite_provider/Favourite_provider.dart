import 'package:flutter/material.dart';
import '../../model/favourite_modal/favourite_modal.dart';
import '../../services/favourite_api_helper/favourite_api_helper.dart';

class FavouriteProvider with ChangeNotifier {
  List<FavouriteModel> items = [];

  Future<void> fetchFavourites(int userId) async {
   items = await ApiHelperClass.getFavourites(userId);
    notifyListeners();
  }

  // --------------------------------
  // Add Favourite
  // --------------------------------
  Future<void> addFavourite(int userId, int resId) async {
    final success = await ApiHelperClass.addFavourite(userId, resId);

    if (success) {
      items.add(
        FavouriteModel(
          fevoId: 0,
          userId: userId,
          resId: resId,
        ),
      );
      notifyListeners();
    }
  }

  // --------------------------------
  // Remove Favourite
  // --------------------------------
  Future<bool> removeFavourite(int fevoId) async {
    final success = await ApiHelperClass.deleteFavourite(fevoId);

    if (success) {
      items.removeWhere((item) => item.fevoId == fevoId);
      notifyListeners();
    }
    return success;
  }

  // --------------------------------
  // Check if Favourite
  // --------------------------------
  bool isFavourite(int resId) {
    return items.any((item) => item.resId == resId);
  }
}
