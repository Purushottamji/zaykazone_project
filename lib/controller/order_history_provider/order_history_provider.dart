import 'package:flutter/material.dart';
import '../../model/order_history_model/order_history_model.dart';
import '../../services/order_history_api_service/order_history_api_service.dart';

class OrderHistoryProvider with ChangeNotifier{

  List<OrderHistoryModal> listData=[];

  orderHistoryFetch(int userId)async{
    var response=await OrderHistoryApi.getOrderHistory(userId);
    if(response!=null){
      listData.addAll(response);
      notifyListeners();

    }

  }

}

