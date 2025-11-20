import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zaykazone/controller/state_manage/onboarding_provider.dart';
import 'package:zaykazone/view/screens/login_page/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height * 0.03),

          CarouselSlider(
            carouselController: onboardingProvider.carouselSliderController,
            items: [
              buildSlide(
                title: "All your favourite",
                subTitle:
                "Get all your loved foods in one place. You place the order, we do the rest.",
                imageURL: "assets/images/onboarding1.png",
                height: height,
                width: width,
              ),
              buildSlide(
                title: "Order from chosen chefs",
                subTitle:
                "Order from top chefs and get your favourite meals instantly.",
                imageURL: "assets/images/onboarding2.png",
                height: height,
                width: width,
              ),

              buildSlide(
                title: "Free delivery offers",
                subTitle:
                "Enjoy free delivery everyday on your favourite food.",
                imageURL: "assets/images/onboarding3.png",
                height: height,
                width: width,
              ),
            ],
            options: CarouselOptions(
              height: height * 0.60,
              viewportFraction: 0.95,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  onboardingProvider.carouselNextPage(index),
            ),
          ),

          const SizedBox(height: 20),

          AnimatedSmoothIndicator(
            activeIndex: onboardingProvider.currentIndex,
            count: 3,
            effect: ScrollingDotsEffect(
              activeDotColor: Color(0xffFF620D),
              dotColor: Colors.black26,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 15,
            ),
          ),

          SizedBox(height: height * 0.03),

          SizedBox(
            height: 55,
            width: width * 0.65,
            child: ElevatedButton(
              onPressed: () {
                if (onboardingProvider.currentIndex < 2) {
                  onboardingProvider.carouselSliderController.nextPage();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
                onboardingProvider.setOnboardingStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF620D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                onboardingProvider.currentIndex == 2
                    ? "GET STARTED"
                    : "NEXT",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
          ),

          SizedBox(height: height * 0.02),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  Widget buildSlide({
    required String title,
    required String subTitle,
    required String imageURL,
    required double height,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            height: height * 0.33,
            width: width * 0.80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: height * 0.03),

          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: height * 0.02),

          Text(
            subTitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
