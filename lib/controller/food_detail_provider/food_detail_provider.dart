import 'package:flutter/cupertino.dart';
import '../../model/food_model/food_model.dart';
import '../../services/food_api_service/food_api_service.dart';

class FoodDetailProvider with ChangeNotifier {

  bool isLoading = false;

  List<FoodModel> _allFoods = [];
  List<FoodModel> filteredFoods = [];

  dynamic _restaurantId;
  String _searchQuery = "";

  Future<void> fetchFood() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await FoodApiService.fetchFood();

      _allFoods = response ?? [];
      _applyFilters();

    } catch (e) {
      debugPrint("Fetch food error: $e");
      _allFoods = [];
      filteredFoods = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setRestaurant(dynamic restaurantId) {
    _restaurantId = restaurantId;
    _applyFilters();
  }

  void clearRestaurant() {
    _restaurantId = null;
    _applyFilters();
  }

  void searchFood(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    filteredFoods = _allFoods.where((food) {
      final restaurantMatch =
          _restaurantId == null || food.restaurantId == _restaurantId;

      final searchMatch =
          _searchQuery.isEmpty ||
              (food.name ?? "")
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());

      return restaurantMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  void clear() {
    _allFoods.clear();
    filteredFoods.clear();
    _restaurantId = null;
    _searchQuery = "";
    notifyListeners();
  }
}
