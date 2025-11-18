import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zaykazone/controller/state_manage/onboarding_provider.dart';

import '../home/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var boardingProvider = Provider.of<OnboardingProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: boardingProvider.carouselSliderController,
            items: [
              containerDesign(
                "All your favourite",
                "Get all your loved foods in one once place,you just place the order we do the rest",
                280,
                300,
                "assets/images/food1.png",
              ),
              containerDesign(
                "Order from chosen chef",
                "Get all your loved foods in one once place,you just place the order we do the rest",
                280,
                300,
                "assets/images/food2.png",
              ),
              containerDesign(
                "Free delivery offers",
                "Get all your loved foods in one once place,you just place the order we do the rest",
                280,
                300,
                "assets/images/food3.png",
              ),
            ],
            options: CarouselOptions(
              height: 430,
              onPageChanged: (index, reason) {
                boardingProvider.carouselNextPage(index);
              },
              viewportFraction: 0.95,
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: boardingProvider.currentIndex,
            count: 3,
            effect: ScrollingDotsEffect(
              activeDotColor: Color(0xffFF620D),
              dotColor: Color(0x99000000),
              dotHeight: 10,
              dotWidth: 10,
              spacing: 15,
            ),
          ),

          SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                if (boardingProvider.currentIndex < 2) {
                  boardingProvider.carouselSliderController.nextPage();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
                boardingProvider.setOnboardingStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF620D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
              ),),
              child: Text(
                boardingProvider.currentIndex == 3 ? "GET STARTED" : "NEXT",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 15,),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerDesign(
    String title,
    String subTitle,
    double height,
    double width,
    String imageURL,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subTitle,
            style: TextStyle(fontSize: 16, color: Color(0x99000000)),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
