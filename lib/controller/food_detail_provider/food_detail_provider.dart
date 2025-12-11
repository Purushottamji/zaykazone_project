import 'package:flutter/cupertino.dart';
import '../../model/food_model/food_model.dart';
import '../../services/food_api_service/food_api_service.dart';

class FoodDetailProvider with ChangeNotifier {
  List<FoodModel> foodList = [];
  List<FoodModel> filteredFoods = [];

  // Fetch API Data
  fetchFood() async {
    var data = await FoodApiService.fetchFood();
    if (data != null) {
      foodList = data;
      filteredFoods = List.from(foodList);
      notifyListeners();
    }
  }

  // Search Function
  void searchFood(String query) {
    if (query.isEmpty) {
      filteredFoods = List.from(foodList);
    } else {
      final lowerQuery = query.toLowerCase();

      filteredFoods = foodList.where((food) {
        final name = food.name.toLowerCase();
        return name.contains(lowerQuery);
      }).toList();
    }

    notifyListeners();
  }
}
