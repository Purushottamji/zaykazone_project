import 'package:flutter/material.dart';
import 'package:zaykazone/model/food_model/food_model.dart';

class FavouriteProvider with ChangeNotifier {
  final List<FoodModel> _items = [];

  List<FoodModel> get items => _items;

  void toggleFavourite(FoodModel food) {
    if (_items.contains(food)) {
      _items.remove(food);
    } else {
      _items.add(food);
    }
    notifyListeners();
  }

  bool isFavourite(FoodModel food) {
    return _items.contains(food);
  }
}
