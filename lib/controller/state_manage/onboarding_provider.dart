import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  int currentIndex = 0;

  carouselNextPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> setOnboardingStatus() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool('onBoardingStatus', true);
    notifyListeners();
  }
}
