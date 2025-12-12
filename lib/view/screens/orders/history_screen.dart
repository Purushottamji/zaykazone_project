import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/order_provider/order_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrderProvider>(context);

    var data = provider.orderData?.result ?? [];
    var history = data.where((e) => e.quantity == 1).toList();

    if (history.isEmpty) {
      return Center(child: Text("No history orders"));
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        var item = history[index];

        return ListTile(
          leading: Icon(Icons.history, color: Colors.orange),
          title: Text(item.foodName),
          subtitle: Text("Qty: ${item.quantity}"),
          trailing: Text("₹ ${item.totalPrice}"),
        );
      },
    );
  }
}
