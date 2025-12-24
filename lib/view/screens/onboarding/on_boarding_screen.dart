import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zaykazone/view/screens/login_page/login_screen.dart';
import 'dart:ui';
import '../../../controller/onboarding_provider/onboarding_provider.dart';

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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D), // 🔥 brand glow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.1),

            /// 🔥 Glass Carousel
            CarouselSlider(
              carouselController: onboardingProvider.carouselSliderController,
              items: [
                _glassSlide(
                  title: "All your favourite",
                  subTitle:
                      "Get all your loved foods in one place. You place the order, we do the rest.",
                  imageURL: "assets/images/onboarding1.png",
                  height: height,
                  width: width,
                ),
                _glassSlide(
                  title: "Order from chosen chefs",
                  subTitle:
                      "Order from top chefs and get your favourite meals instantly.",
                  imageURL: "assets/images/onboarding2.png",
                  height: height,
                  width: width,
                ),
                _glassSlide(
                  title: "Free delivery offers",
                  subTitle:
                      "Enjoy free delivery everyday on your favourite food.",
                  imageURL: "assets/images/onboarding3.png",
                  height: height,
                  width: width,
                ),
              ],
              options: CarouselOptions(
                height: height * 0.58,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    onboardingProvider.carouselNextPage(index),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔘 Indicator
            AnimatedSmoothIndicator(
              activeIndex: onboardingProvider.currentIndex,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xffFF620D),
                dotColor: Colors.white38,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 10,
              ),
            ),

            SizedBox(height: height * 0.04),

            /// 🔥 Glass CTA Button
            _glassButton(
              width: width,
              text:
                  onboardingProvider.currentIndex == 2 ? "GET STARTED" : "NEXT",
              onTap: () {
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
            ),

            SizedBox(height: height * 0.02),

            /// Skip
            TextButton(
              onPressed: () async {
                await onboardingProvider.setOnboardingStatus();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFF620D),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }

  Widget _glassSlide({
    required String title,
    required String subTitle,
    required String imageURL,
    required double height,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.31,
                  width: width * 0.8,
                  child: Image.asset(
                    imageURL,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  subTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassButton({
    required double width,
    required String text,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SizedBox(
          height: 55,
          width: width * 0.65,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF620D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
