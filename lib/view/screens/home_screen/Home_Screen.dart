import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/food_detail_provider/food_detail_provider.dart';
import 'package:zaykazone/view/screens/burger_screen/burger_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/food_details_screen.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';
import '../../../controller/bottom_nav_provider/bottom_nav_provider.dart';
import '../../../controller/restaurant_details_provider/restaurant_details_provider.dart';
import '../detail_screen/restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  Map<int, bool> expandedMap = {};

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Future.microtask(() {
      Provider.of<RestaurantDetailsProvider>(
        context,
        listen: false,
      ).getProduct();
      Provider.of<FoodDetailProvider>(context, listen: false).fetchFood();
    });

    searchController.addListener(() {
      final query = searchController.text;
      Provider.of<FoodDetailProvider>(context, listen: false).searchFood(query);
      Provider.of<RestaurantDetailsProvider>(context, listen: false)
          .searchRestaurants(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantDetailsProvider>(context);
    final foodProvider = Provider.of<FoodDetailProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final hasSearch = searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A), // dark base
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _glassSliverAppBar(context),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 10,
                  ),
                  if (!hasSearch) ...[
                    _sectionTitle(
                      "All Categories",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FoodItemsListScreen(),
                        ),
                      ),
                    ),
                    _glassCategoryList(foodProvider),
                    _sectionTitle(
                      "Open Restaurants",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantScreen(),
                        ),
                      ),
                    ),
                    _glassRestaurantList(
                      provider,
                      screenWidth,
                      screenHeight,
                    ),
                  ],
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverAppBar _glassSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Delivery",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          Text(
            "ZaykaZone Office",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFF620D).withOpacity(0.60),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: _glassSearchBar(context),
        ),
      ),
    );
  }

  Widget _glassSearchBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextField(
          readOnly: true,
          onTap: () {
            Provider.of<BottomNavProvider>(context, listen: false)
                .changeIndex(1);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.25),
            hintText: "Search dishes, restaurants...",
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xffFF620D), // 🔥 brand icon
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: const [
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCategoryList(FoodDetailProvider foodProvider) {
    final foods = foodProvider.filteredFoods;
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length > 5 ? 5 : foods.length,
        itemBuilder: (context, index) {
          final item = foodProvider.filteredFoods[index];

          return Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    border: Border.all(
                      color: const Color(0xffFF620D).withOpacity(0.35),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final provider = Provider.of<FoodDetailProvider>(context, listen: false);
                      provider.clearRestaurant();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BurgerScreen(allFood: item),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.image,
                            height: 100,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _glassRestaurantList(
    RestaurantDetailsProvider provider,
    double screenWidth,
    double screenHeight,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.filteredRestaurants.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final item = provider.filteredRestaurants[index];
        final isExpanded = expandedMap[index] ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  border: Border.all(
                    color: const Color(0xffFF620D).withOpacity(0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RestaurantDetailsScreen(restaurant: item),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.image_url!,
                          height: screenHeight * 0.2,
                          width: screenWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.name ?? "",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item.description ?? "",
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
