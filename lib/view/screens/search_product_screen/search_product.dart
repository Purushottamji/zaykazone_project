import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../../controller/restaurant_details_provider/restaurant_details_provider.dart';
import '../../../controller/food_detail_provider/food_detail_provider.dart';
import '../../../controller/search_provider/search_provider.dart';
import '../burger_screen/burger_screen.dart';
import '../detail_screen/restaurant_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchCtrl.addListener(() {
      final query = searchCtrl.text;
      Provider.of<FoodDetailProvider>(context, listen: false).searchFood(query);
      Provider.of<RestaurantDetailsProvider>(context, listen: false)
          .searchRestaurants(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodDetailProvider>(context);
    final restProvider = Provider.of<RestaurantDetailsProvider>(context);
    final searchProv = Provider.of<SearchProvider>(context);

    final hasQuery = searchCtrl.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _glassSearchAppBar(searchProv),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: hasQuery
                    ? _buildSearchResults(foodProvider, restProvider)
                    : _buildRecentAndSuggestions(searchProv),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _glassSearchAppBar(SearchProvider searchProv) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Search Food",
        style: TextStyle(color: Colors.white),
      ),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: const Color(0xffFF620D).withOpacity(0.60),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: _glassSearchField(searchProv),
        ),
      ),
    );
  }

  Widget _glassSearchField(SearchProvider searchProv) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextField(
          controller: searchCtrl,
          autofocus: true,
          onSubmitted: searchProv.addToRecent,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search dishes, restaurants...",
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.25),
            prefixIcon: const Icon(Icons.search, color: Color(0xffFF620D)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentAndSuggestions(SearchProvider searchProv) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (searchProv.recentSearches.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: searchProv.clearRecent,
                child: const Text("Clear",
                    style: TextStyle(color: Color(0xffFF620D))),
              )
            ],
          ),
        ...searchProv.recentSearches.map(
          (item) => _glassListTile(
            icon: Icons.history,
            title: item,
            onTap: () {
              searchCtrl.text = item;
              searchProv.addToRecent(item);
            },
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.white70),
              onPressed: () => searchProv.deleteRecent(item),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Popular Searches",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: searchProv.suggestions
              .map(
                (s) => GestureDetector(
                  onTap: () {
                    searchCtrl.text = s;

                    searchCtrl.selection = TextSelection.fromPosition(
                      TextPosition(offset: searchCtrl.text.length),
                    );

                    searchProv.addToRecent(s);

                    Provider.of<FoodDetailProvider>(context, listen: false)
                        .searchFood(s);
                    Provider.of<RestaurantDetailsProvider>(context,
                            listen: false)
                        .searchRestaurants(s);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Chip(
                        label: Text(s, style: const TextStyle(color: Colors.white)),
                        backgroundColor: const Color(0xffFF620D),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults(foodProvider, restProvider) {
    return Column(
      children: [
        ...foodProvider.filteredFoods.map(
          (item) => _glassListTile(
            image: item.image,
            title: item.name,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BurgerScreen(allFood: item),
              ),
            ),
          ),
        ),
        ...restProvider.filteredRestaurants.map(
          (item) => _glassListTile(
            image: item.image_url,
            title: item.name ?? "",
            subtitle: item.description ?? "",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantDetailsScreen(restaurant: item),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _glassListTile({
    String? image,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: ListTile(
            onTap: onTap,
            tileColor: Colors.white.withOpacity(0.18),
            leading: image != null
                ? Image.network(image, width: 50, fit: BoxFit.cover)
                : icon != null
                    ? Icon(icon, color: Colors.white)
                    : null,
            title: Text(title, style: const TextStyle(color: Colors.white)),
            subtitle: subtitle != null
                ? Text(subtitle, style: const TextStyle(color: Colors.white70))
                : null,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
