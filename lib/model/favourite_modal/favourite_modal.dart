class FavouriteModel {
  final int fevoId;
  final int userId;
  final int resId;

  FavouriteModel({
    required this.fevoId,
    required this.userId,
    required this.resId,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      fevoId: json['fevo_id'] ?? -1,
      userId: json['id'] ?? -1,
      resId: json['res_id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() => {
    "fevo_id": fevoId,
    "id": userId,
    "res_id": resId,
  };
}
