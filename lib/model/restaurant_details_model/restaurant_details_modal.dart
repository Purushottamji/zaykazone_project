class RestaurantDetailsModal {
  dynamic id;
  String? name;
  String? image_url;
  String? description;
  String? food_details;
  String? address;
  dynamic rating;
  String? delivery_charge;
  String? delivery_time;

  RestaurantDetailsModal(
      this.id,
    this.name,
    this.image_url,
    this.description,
    this.food_details,
    this.address,
    this.delivery_charge,
    this.delivery_time,
    this.rating,
  );

  static RestaurantDetailsModal getModal(Map<String, dynamic> data) {
    return RestaurantDetailsModal(
      data['res_id'],
      data['name'],
      data['image_url'],
      data['description'],
      data['food_details'],
      data['address'],
      data['delivery_charge'],
      data['delivery_time'],
      data['rating'],
    );
  }
}
