class FavouriteFoodModel {
  final int favouriteId;
  final int foodId;
  final String name;
  final String image;
  final String price;

  FavouriteFoodModel({
    required this.favouriteId,
    required this.foodId,
    required this.name,
    required this.image,
    required this.price,
  });

  factory FavouriteFoodModel.fromJson(Map<String, dynamic> json) {
    return FavouriteFoodModel(
      favouriteId: json['fav_id'],
      foodId: json['food_id'],
      name: json['food_name'],
      image: json['image'],
      price: json['price'].toString(),
    );
  }
}
