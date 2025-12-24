class RatingModel {
  int id;
  int? resId;
  String? productName;
  String? experience;
  double? rating;
  int? user_id;
  String? user_name;

  RatingModel({
   required this.id,
    this.resId,
    this.productName,
    this.experience,
    this.rating,
    this.user_id,
    this.user_name
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json["id"],
      resId: int.tryParse(json["res_id"].toString()),
      productName: json["product_name"].toString(),
      experience: json["experience"].toString(),
      rating: double.tryParse(json["rating"].toString()) ?? 0.0,
      user_id: json["user_id"],
      user_name: json["user_name"]
    );
  }
}
