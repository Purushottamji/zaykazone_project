class OrderModal {
  List<OrderItem> result;

  OrderModal({required this.result});

  factory OrderModal.fromJson(Map<String, dynamic> json) {
    return OrderModal(
      result: List<OrderItem>.from(
        json["result"].map((x) => OrderItem.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
  }
}

class OrderItem {
  int orderId;
  int resId;
  String foodName;
  int quantity;
  int totalPrice;
  int userId;
  int pOaId;

  OrderItem({
    required this.orderId,
    required this.resId,
    required this.foodName,
    required this.quantity,
    required this.totalPrice,
    required this.userId,
    required this.pOaId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderId: json["order_id"],
      resId: json["res_id"],
      foodName: json["food_name"],
      quantity: json["quantity"],
      totalPrice: json["total_price"],
      userId: json["user_id"],
      pOaId: json["p_o_a_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "res_id": resId,
      "food_name": foodName,
      "quantity": quantity,
      "total_price": totalPrice,
      "user_id": userId,
      "p_o_a_id": pOaId,
    };
  }
}
