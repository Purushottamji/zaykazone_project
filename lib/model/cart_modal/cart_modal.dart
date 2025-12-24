class CartModel {
  int? id;
  String title;
  String image;
  double price;
  int quantity;
  int resId;

  CartModel({
    this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.resId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
      'restaurant_id':resId
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
      resId: map['restaurant_id']
    );
  }
}

