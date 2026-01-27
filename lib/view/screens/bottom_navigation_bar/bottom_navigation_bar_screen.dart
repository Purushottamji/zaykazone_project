
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/services/place_order_address_api/place_order_address_api.dart';
import 'package:zaykazone/services/user_address_service/user_address_service.dart';
import 'package:zaykazone/view/screens/search_product_screen/search_product.dart';
import '../../../controller/bottom_nav_provider/bottom_nav_provider.dart';
import '../../../controller/place_order_address_provider/place_order_address_provider.dart';
import '../../../controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import '../../../services/rating_api_service/rating_api.dart';
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
  @override
  void initState() {
    super.initState();
    loadUserAndAddress();
  }

  Future<void> loadUserAndAddress() async {
    final loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    Provider.of<PlaceOrderAddressProvider>(context, listen: false)
        .addressGet(context);
    await loginProvider.getUser();
    UserAddressService.storeUserId(context);
    PlaceOrderAddressApi.storeUserId(context);
    RatingApi.storeUserId(context);
  }

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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: screens[bottomNav.currentIndex],
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _GlassBottomNavBar(
              currentIndex: bottomNav.currentIndex,
              onTap: (index) {
                bottomNav.changeIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _GlassBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xffFF620D).withOpacity(0.90),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                icon: Icons.home_outlined,
                index: 0,
                label: "Home",
              ),
              _navItem(
                icon: Icons.search,
                index: 1,
                label: "Search",
              ),
              _navItem(
                icon: Icons.shopping_cart_outlined,
                index: 2,
                label: "Cart",
              ),
              _navItem(
                icon: Icons.person_outline,
                index: 3,
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.25)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
