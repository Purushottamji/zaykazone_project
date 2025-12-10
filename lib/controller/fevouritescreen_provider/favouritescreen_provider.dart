import 'package:flutter/material.dart';
import 'package:zaykazone/services/ApiHelper/ApiHelper.dart';

import '../../model/FavouriteModel/FavouriteModel.dart';

class FavouriteProvider extends ChangeNotifier {
  List<FavouriteModel> favourites = [];
  bool isLoading = false;


  Future<void> loadFavourites(int userId) async {
    isLoading = true;
    notifyListeners();


    favourites = await ApiHelperClass.getFavourites(userId);


    isLoading = false;
    notifyListeners();
  }


  Future<void> addFavourite(int userId, int resId) async {
    bool success = await ApiHelperClass.addFavourite(userId, resId);
    if (success) {
      await loadFavourites(userId);
    }
  }


  Future<void> removeFavourite(int fevoId, int userId) async {
    bool success = await ApiHelperClass.deleteFavourite(fevoId);
    if (success) {
      await loadFavourites(userId);
    }
  }
}