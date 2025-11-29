import 'package:flutter/material.dart';
import 'package:zaykazone/model/cart_modal/cart_modal.dart';
import '../services/cart_db_helper/cart_dbHelper.dart';
class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  Future<void> loadCart() async {
    cartList = await CartDB.instance.getCartItems();
    notifyListeners();
  }

  Future<void> addToCart(CartModel item) async {
    await CartDB.instance.insertCart(item);
    await loadCart();
  }

  Future<void> updateCart(CartModel item) async {
    await CartDB.instance.updateCart(item);
    await loadCart();
  }


  Future<void> removeItem(int id) async {
    await CartDB.instance.deleteCart(id);
    await loadCart();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in cartList) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
