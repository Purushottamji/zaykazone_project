class FoodModel {
   int id;
   String name;
   String description;
   String image;
   double price;
   double rating;
   String restaurant_name;
  
  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.restaurant_name
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      rating: json["rating"],
      restaurant_name: json["restaurant_name"],
    );
  }
}
