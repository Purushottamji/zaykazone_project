class OfferModel {
  final String title;
  final String code;
  final double discountPercent;
  final double minOrderValue;
  final DateTime expiry;
  final bool isActive;

  OfferModel({
    required this.title,
    required this.code,
    required this.discountPercent,
    required this.minOrderValue,
    required this.expiry,
    this.isActive = true,
  });

  bool get isExpired => DateTime.now().isAfter(expiry);
}
