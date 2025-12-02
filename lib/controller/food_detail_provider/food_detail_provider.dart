import 'package:flutter/material.dart';
import 'package:zaykazone/model/food_model/food_model.dart';
import 'package:zaykazone/services/food_api_service/food_api_service.dart';

class FoodDetailProvider with ChangeNotifier{
  List<FoodModel> foodList=[];

  Future fetchFood() async{
    var data=await FoodApiService.fetchFood();
    if(data!=null){
      foodList=data;
      notifyListeners();
    }
  }
}