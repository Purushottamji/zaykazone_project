import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/food_detail_provider/food_detail_provider.dart';
import 'package:zaykazone/controller/user_address_provider/user_address_provider.dart';
import 'package:zaykazone/services/user_address_service/user_address_service.dart';
import 'package:zaykazone/view/screens/search_product_screen/search_product.dart';
import '../../../controller/bottom_nav_provider/bottom_nav_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../home_screen/Home_Screen.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNav = Provider.of<BottomNavProvider>(context);

    final List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      MyCartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: screens[bottomNav.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNav.currentIndex,
        onTap: (value) {
          bottomNav.changeIndex(value);
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

