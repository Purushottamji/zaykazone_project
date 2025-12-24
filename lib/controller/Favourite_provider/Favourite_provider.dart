import 'package:flutter/material.dart';
import '../../model/favourite_model/favourite_model.dart';
import '../../services/favourite_api_service/favourite_api_service.dart';
import '../../utils/token_helper/token_helper.dart';

class FavouritePro extends ChangeNotifier {
  List<FavouriteFoodModel> _items = [];
  List<FavouriteFoodModel> get items => _items;

  bool isLoading = false;

  Future<void> getFavourites() async {
    final token = await TokenHelper.getToken();
    if (token == null) return;

    isLoading = true;
    notifyListeners();

    try {
      _items = await FavouriteFoodApi.getFavouriteFood();
    } catch (e) {
      debugPrint("GET FAV ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  bool isFavourite(int foodId) {
    return _items.any((e) => e.foodId == foodId);
  }

  FavouriteFoodModel? getFavouriteByFoodId(int foodId) {
    try {
      return _items.firstWhere((e) => e.foodId == foodId);
    } catch (_) {
      return null;
    }
  }

  Future<void> addFavourite({
    required int id,
    required String name,
    required String image,
    required String price,
  }) async {
    final favId = await FavouriteFoodApi.addFavourite(id);

    _items.add(
      FavouriteFoodModel(
        favouriteId: favId,
        foodId: id,
        name: name,
        image: image,
        price: price,
      ),
    );

    notifyListeners();
  }

  Future<void> removeFavourite(int favId) async {
    await FavouriteFoodApi.removeFavourite(favId);
    _items.removeWhere((e) => e.favouriteId == favId);
    notifyListeners();
  }
}