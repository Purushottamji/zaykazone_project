import 'package:flutter/material.dart';
import '../../model/order_modal/order_modal.dart';
import '../../services/order_api/order_api.dart';

class OrderProvider with ChangeNotifier {
  OrderModal? orderData;
  bool isLoading = false;

  Future<void> fetchOrders() async {
    isLoading = true;
    notifyListeners();

    var response = await OrderApi.getOrder();

    if (response != null) {
      orderData = response;
    }

    isLoading = false;
    notifyListeners();
  }
}
