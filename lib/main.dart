import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:zaykazone/controller/food_detail_provider/food_detail_provider.dart';
import 'package:zaykazone/controller/order_provider/order_provider.dart';
import 'package:zaykazone/rating_provider/rating_provider.dart';
import 'package:zaykazone/controller/place_order_address_provider/place_order_address_provider.dart';
import 'package:zaykazone/controller/search_provider/search_provider.dart';
import 'package:zaykazone/view/screens/splash/splash_screen.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_phone/from_phone.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_whatsapp/from_whatsapp_login.dart';
import 'package:zaykazone/controller/user_auth_provider/signup_provider/signup_provider.dart';

import 'controller/Favourite_provider/Favourite_provider.dart';
import 'controller/cart_provider/cart_provider.dart';
import 'controller/onboarding_provider/onboarding_provider.dart';

import 'controller/restaurant_details_provider/restaurant_details_provider.dart';
import 'controller/restaurant_details_provider/restaurant_provider.dart';
import 'controller/user_address_provider/user_address_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantProvider(),),
        ChangeNotifierProvider(create: (context) => RestaurantDetailsProvider(),),
        ChangeNotifierProvider(create: (context) => CartProvider(),),
        ChangeNotifierProvider(create: (context) => FoodDetailProvider(),),
        ChangeNotifierProvider(create: (context) => RatingProvider(),),

        ChangeNotifierProvider(create: (context) => UserAddressProvider(),),
        ChangeNotifierProvider(create: (context) => FromWhatsappLogin()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => PhoneAuthProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (context) => UserAddressProvider(),),
        ChangeNotifierProvider(create: (context) => BottomNavProvider(),),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => PlaceOrderAddressProvider(),),
        ChangeNotifierProvider(create: (context) => OrderProvider(),)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffFF620D),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xffFF620D),
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.black,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
            ),
          ),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
