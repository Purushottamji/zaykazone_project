
class FavouriteModel {
  final int fevoId;
  final int resId;
  final int id;
  final String restaurantName;
  final String restaurantImage;
  final String restaurantAddress;


  FavouriteModel({
    required this.fevoId,
    required this.resId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.restaurantAddress,
    required this.id,
  });


  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      fevoId: json['fevo_id'],
      id: json['id'],
      resId: json['res_id'],
      restaurantName: json['res_name'] ?? '',
      restaurantImage: json['res_image'] ?? '',
      restaurantAddress: json['res_address'] ?? '',
    );
  }
}