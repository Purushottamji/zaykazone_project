import 'dart:convert';

class FoodModel {
  final int id;
  final String name;
  final String restaurantName;
  final String image;
  final String price;
  // final int price;

  FoodModel({
    required this.id,
    required this.name,
    required this.restaurantName,
    required this.image,
    required this.rating,
    required this.deliveryType,
    required this.time,
    required this.description,
    required this.sizes,
    required this.ingredients,
    required this.price,
    required this.quantity,
    required this.restaurantId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      restaurantName: json['restaurant_name'] ?? "",
      image: json['image'] ?? "",
      rating: json['rating'] ?? "",
      deliveryType: json['delivery_type'] ?? "",
      time: json['time'] ?? "",
      description: json['description'] ?? "",


      sizes: _convertStringToList(json['sizes']),
      ingredients: _convertStringToList(json['ingredients']),

      price: json['price'] ?? "",
      quantity: json['quantity'] ?? 0,
      restaurantId: json['restaurant_id'],
    );
  }

  static List<String> _convertStringToList(dynamic value) {
    if (value == null) return [];

    try {

      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }

      return List<String>.from(jsonDecode(value));
    } catch (e) {
      return [];
    }
  }
}
