import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/order_provider/order_provider.dart';
import 'package:zaykazone/view/screens/orders/history_screen.dart';
import 'package:zaykazone/view/screens/orders/OngoingScreen.dart';
import 'package:zaykazone/view/screens/edit_profile/edit_profile.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context,listen: false).fetchOrders();
    },);
  }
  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffFF620D),
            foregroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "My Orders",
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: "Ongoing"),
                Tab(text: "History"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              OngoingScreen(),
              HistoryScreen(),
            ],
          ),
        ),
      ),
    );
  }
}



