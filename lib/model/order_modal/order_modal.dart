class OrderModal {
  final List<OrderResult> result;

  OrderModal({required this.result});

  factory OrderModal.fromJson(Map<String, dynamic> json) {
    return OrderModal(
      result: (json['result'] as List? ?? [])
          .map((e) => OrderResult.fromJson(e))
          .toList(),
    );
  }
}

class OrderResult {
  final int orderId;
  final int resId;
  final String foodName;
  final int quantity;
  final double totalPrice;
  final int userId;
  final int pOAId;
  final String? image;
  late String status;
  final String? userName;
  final String? paymentStatus;
  final String? paymentMethod;

  OrderResult({
    required this.orderId,
    required this.resId,
    required this.foodName,
    required this.quantity,
    required this.totalPrice,
    required this.userId,
    required this.pOAId,
    this.image,
    required this.status,
    this.userName,
    this.paymentStatus,
    this.paymentMethod
  });

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    return OrderResult(
      orderId: json['order_id'],
      resId: json['res_id'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      totalPrice: double.parse(json['total_price'].toString()),
      userId: json['user_id'],
      pOAId: json['p_o_a_id'],
      image: json['image'],
      status: json['status'] ?? "Pending",
      userName: json['user_name'] ?? "",
      paymentStatus: json['payment_status'] ?? "Pending",
      paymentMethod: json['payment_method'] ?? "Cash On Delivery"
    );
  }
}
