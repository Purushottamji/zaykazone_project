import 'package:flutter/material.dart';
import 'package:zaykazone/model/order_history_modal/order_history_modal.dart';
import 'package:zaykazone/services/order_history_api/order_history_api.dart';

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


