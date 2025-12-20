class PaymentModal {
  int? id;
  int? userId;
  String? cardHolderName;
  String? cardNumber;
  String? expDate;
  String? cvv;

  PaymentModal({
    this.id,
    this.userId,
    this.cardHolderName,
    this.cardNumber,
    this.expDate,
    this.cvv,
  });

  factory PaymentModal.fromJson(Map<String, dynamic> json) {
    return PaymentModal(
      id: json['id'],
      userId: json['user_id'],
      cardHolderName: json['card_holder_name'],
      cardNumber: json['card_number'],
      expDate: json['exp_date'],
      cvv: json['cvv'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "card_holder_name": cardHolderName,
      "card_number": cardNumber,
      "exp_date": expDate,
      "cvv": cvv,
    };
  }
}
