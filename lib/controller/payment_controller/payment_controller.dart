import 'package:flutter/cupertino.dart';
import '../../model/payment_model/payment_model.dart';
import '../../services/payment_api_service/payment_api_service.dart';

class PaymentProvider with ChangeNotifier {
  final cartNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHolderNameController = TextEditingController();

  List<PaymentModal> listData = [];

  Future<void> fetchData(int userId) async {
    listData.clear();
    listData = await PaymentApi.getPayment(userId);
    notifyListeners();
  }

  Future<void> postData(int userId) async {
    final body = {
      "user_id": userId,
      "card_holder_name": cardHolderNameController.text.trim(),
      "card_number": cartNumberController.text.trim(),
      "exp_date": expiryDateController.text.trim(),
      "cvv": cvvController.text.trim(),
    };

    final response = await PaymentApi.addPayment(userId, body);

    if (response != null) {
      listData.add(response);

      cardHolderNameController.clear();
      cartNumberController.clear();
      expiryDateController.clear();
      cvvController.clear();

      notifyListeners();
    }
  }

  Future<void> deleteData(int paymentId) async {
    bool isDeleted = await PaymentApi.deletePayment(paymentId);

    if (isDeleted) {
      listData.removeWhere((e) => e.id == paymentId);
      notifyListeners();
    }
  }
}