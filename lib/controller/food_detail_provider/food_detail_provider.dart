import 'package:flutter/cupertino.dart';

import '../../model/food_model/food_model.dart';
import '../../services/food_api_service/food_api_service.dart';

class FoodDetailProvider with ChangeNotifier {
  List<FoodModel> foodList = [];

  fetchFood() async {
    var data = await FoodApiService.fetchFood();
    if (data != null) {
      foodList = data;
      notifyListeners();
    }
  }
}
