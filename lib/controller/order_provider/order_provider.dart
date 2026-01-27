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
    required String userName,
    required String paymentStatus,
    required String paymentMethod,
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
      "user_name": userName,
      "payment_status" : paymentStatus,
      "payment_method": paymentMethod
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
    required String userName,
    required String paymentStatus,
    required String paymentMethod,
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
        "user_name": userName,
        "payment_status" : paymentStatus,
        "payment_method": paymentMethod
      });
    }

    isPlacingOrder = false;
    notifyListeners();
    await fetchOrders(userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All items ordered successfully")),
    );
  }

  ///Order Status Update

  Future<void> updatePaymentStatus( BuildContext context,
      {required int orderId,required String paymentStatus}) async {

    final success = await OrderApi.updateOrderStatus(orderId,paymentStatus);

    if (success) {
      final order = orderData?.result
          .firstWhere((e) => e.orderId == orderId);
      if (order != null) {
        order.status = paymentStatus;
      }


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order status update successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to update order status")),
      );
    }
  }
  /// CANCEL ORDER
  Future<void> cancelOrder(int orderId, BuildContext context) async {
    cancelLoading[orderId] = true;
    notifyListeners();

    final success = await OrderApi.cancelOrder(orderId);

    if (success) {
      final order = orderData?.result
          .firstWhere((e) => e.orderId == orderId);

      if (order != null) {
        order.status = "Cancelled";
      }


    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order cancelled successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to cancel order")),
      );
    }

    cancelLoading.remove(orderId);
    notifyListeners();
  }

}
