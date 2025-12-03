import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/food_detail_provider/food_detail_provider.dart';
import 'package:zaykazone/view/screens/search_product_screen/search_product.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../home_screen/Home_Screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState
    extends State<BottomNavigationBarScreen> {
  int _index = 0;

  final List<Widget> screens = [
    HomeScreen(),
    SearchProductScreen(),
    // CartScreen(),
    MyCartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context,listen: false).getUser();
    Provider.of<FoodDetailProvider>(context,listen: false).fetchFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        backgroundColor: const Color(0xffd56021),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
