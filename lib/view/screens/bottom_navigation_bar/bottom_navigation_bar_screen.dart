import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/search_product_screen/search_product.dart';

import '../profile//profile_screen.dart';
import '../cart/cart_screen.dart';
import '../home_screen/Home_Screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var _index=0;
  List<Widget> screen=[
    HomeScreen(),
    SearchProductScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: screen[_index],
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed,items: [
        BottomNavigationBarItem(icon: Container(
            width: 67,
            height: 37,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: _index==0 ? Colors.orange.shade400 : Colors.grey),
            child: Icon(Icons.home_outlined,color: Colors.white,)),label: "Home"),
        BottomNavigationBarItem(icon: Container(
            width: 67,
            height: 37,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: _index==1 ? Colors.orange.shade400 : Colors.grey),
            child: Icon(Icons.search,color: Colors.white,)),label: "Search"),
        BottomNavigationBarItem(icon: Container(
            width: 67,
            height: 37,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: _index==2 ? Colors.orange.shade400 : Colors.grey),
            child: Icon(Icons.shopping_cart,color: Colors.white,)),label: "Cart",),
        BottomNavigationBarItem(icon: Container(
            width: 67,
            height: 37,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: _index==3 ? Colors.orange.shade400 : Colors.grey),
            child: Icon(Icons.account_circle,color: Colors.white,)),label: "Profile"),
      ],
        onTap: _defaultIndex,
        currentIndex: _index,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
  _defaultIndex(int index){
    setState(() {
      _index=index;
    });
  }
}


