import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/order_history/order_history_provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {

    super.initState();
  // var userId =Provider.of<LoginProvider>(context,listen: false).userData!["id"];
    final userId=92;
    Provider.of<OrderHistoryProvider>(context,listen: false).orderHistoryFetch(userId);
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<OrderHistoryProvider>(context);
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("OrderHistoryScreen"),),
    body: ListView.builder(itemCount:provider.listData.length ,
      itemBuilder: (context, index) {
      var item=provider.listData[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Id:${item.id}"),
          Text("UserId:${item.user_id}"),
          Text("FoodId:${item.food_id}"),
          Text("P_o_a_Id:${item.p_o_a_id}"),
          Text("FoodName:${item.food_name}"),
          Text("Quantity:${item.quantity}"),
          Text("TotalPrice:${item.total_price}"),
        ],),
      );

    },),));
  }
}
