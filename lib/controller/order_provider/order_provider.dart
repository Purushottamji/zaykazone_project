import 'package:flutter/material.dart';
import 'package:zaykazone/model/cart_modal/cart_modal.dart';
import '../../model/order_modal/order_modal.dart';
import '../../services/order_api_service/order_api.dart';

class OrderProvider with ChangeNotifier {
  OrderModal? orderData;
  bool isPlacingOrder=false;
  Map<int, bool> cancelLoading = {};

  /// Live status cache
  Map<int, String> orderStatus = {};

  Future<void> fetchOrders(int userId) async {
    isPlacingOrder = true;
    notifyListeners();

    orderData = await OrderApi.getOrdersByUserId(userId);

    isPlacingOrder = false;
    notifyListeners();
  }

  /// SINGLE FOOD BUY
  Future<void> buyNow({
    required int userId,
    required int resId,
    required String foodName,
    required int quantity,
    required double totalPrice,
    required String? image,
    required int addressId,
    required BuildContext context,
  }) async {
    isPlacingOrder = true;
    notifyListeners();

    final success = await OrderApi.placeOrder({
      "user_id": userId,
      "res_id": resId,
      "food_name": foodName,
      "quantity": quantity,
      "total_price": totalPrice,
      "image": image,
      "p_o_a_id": addressId,
    });

    isPlacingOrder = false;
    notifyListeners();
    await fetchOrders(userId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order placed successfully")),
      );
    }
  }

  /// CART CHECKOUT (MULTIPLE ITEMS)
  Future<void> checkoutCart({
    required int userId,
    required int resId,
    required List<CartModel>? cartItems,
    required int addressId,
    required BuildContext context,
  }) async {
    isPlacingOrder = true;
    notifyListeners();

    for (var item in cartItems!) {
      await OrderApi.placeOrder({
        "user_id": userId,
        "res_id": resId,
        "food_name": item.title,
        "quantity": item.quantity,
        "total_price": item.price * item.quantity,
        "image": item.image,
        "p_o_a_id": addressId,
      });
    }

    isPlacingOrder = false;
    notifyListeners();
    await fetchOrders(userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All items ordered successfully")),
    );
  }
  /// TRACK ORDER
  Future<void> trackOrder(int orderId, BuildContext context) async {
    final status = await OrderApi.trackOrder(orderId);

    if (status != null) {
      orderStatus[orderId] = status;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order Status: $status")),
      );
    }
  }

  /// CANCEL ORDER
  Future<void> cancelOrder(int orderId) async {
    cancelLoading[orderId] = true;
    notifyListeners();

    final success = await OrderApi.cancelOrder(orderId);

    if (success) {
      orderData?.result.removeWhere((e) => e.orderId == orderId);
    }

    cancelLoading.remove(orderId);
    notifyListeners();
  }
}
