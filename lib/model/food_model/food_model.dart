class FoodModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String price;
  // final int price;

  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
    );
  }
}
