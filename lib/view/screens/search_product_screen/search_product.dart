import 'package:flutter/material.dart';
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

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController searchCtrl = TextEditingController();

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
    var foodProvider = Provider.of<FoodDetailProvider>(context);
    var restProvider = Provider.of<RestaurantDetailsProvider>(context);
    var searchProv = Provider.of<SearchProvider>(context);

    bool hasQuery = searchCtrl.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF620D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("Search Food"),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "Search dishes, restaurants...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.black38)),
                  fillColor: Colors.white,
                  filled: true),
              onSubmitted: (v) {
                searchProv.addToRecent(v);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: hasQuery
            ? _buildSearchResults(foodProvider, restProvider)
            : _buildRecentAndSuggestions(searchProv),
      ),
    );
  }

  Widget _buildRecentAndSuggestions(SearchProvider searchProv) {
    return ListView(
      children: [
        if (searchProv.recentSearches.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Searches",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => searchProv.clearRecent(),
                child: Text("Clear"),
              )
            ],
          ),

        Column(
          children: searchProv.recentSearches
              .map(
                (item) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => searchProv.deleteRecent(item),
                  ),
                  onTap: () {
                    searchCtrl.text = item;
                    searchProv.addToRecent(item);
                  },
                ),
              )
              .toList(),
        ),

        SizedBox(height: 20),

        Text("Popular Searches",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: searchProv.suggestions
              .map(
                (s) => GestureDetector(
                  onTap: () {
                    searchCtrl.text = s;
                    searchProv.addToRecent(s);
                  },
                  child: Chip(
                    label: Text(
                      s,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xffFF620D),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _buildSearchResults(foodProvider, restProvider) {
    return ListView(
      children: [
        ...foodProvider.filteredFoods.map((item) {
          return ListTile(
            leading: Image.network(item.image,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(item.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BurgerScreen(allFood: item),
                ),
              );
            },
          );
        }),
        ...restProvider.filteredRestaurants.map((item) {
          return ListTile(
            leading: Image.network(
              item.image_url ?? "",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) => Icon(Icons.broken_image),
            ),
            title: Text(item.name ?? ""),
            subtitle: Text(item.description ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailsScreen(restaurant: item),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
