import 'package:flutter/material.dart';
import '../../model/cart_modal/cart_modal.dart';
import '../../services/cart_db_helper/cart_dbHelper.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  CartProvider() {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    cartList = await CartDB.instance.getCartItems();
    notifyListeners();
  }

  Future<void> addToCart(CartModel item) async {
    await CartDB.instance.insertCart(item);
    await loadCartItems();
  }

  Future<void> updateQuantity(int id, int quantity) async {
    final item = cartList.firstWhere((e) => e.id == id);
    item.quantity = quantity;

    await CartDB.instance.updateCart(item);
    notifyListeners();
  }

  Future<void> removeItem(int id) async {
    await CartDB.instance.deleteCart(id);
    await loadCartItems();
  }

  double get totalAmount {
    double total = 0;
    for (var item in cartList) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
