import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<String> recentSearches = [];
  List<String> suggestions = [
    "Burger",
    "Pizza",
    "Chicken",
    "Biryani",
    "Shawarma",
    "Momos",
    "Ice Cream",
    "Tea",
    "Coffee",
    "Pasta",
  ];

  void addToRecent(String query) {
    if (query.trim().isEmpty) return;

    recentSearches.remove(query);
    recentSearches.insert(0, query);

    if (recentSearches.length > 10) {
      recentSearches = recentSearches.sublist(0, 10);
    }

    notifyListeners();
  }

  void deleteRecent(String query) {
    recentSearches.remove(query);
    notifyListeners();
  }

  void clearRecent() {
    recentSearches.clear();
    notifyListeners();
  }
}
