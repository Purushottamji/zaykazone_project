import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/view/screens/address/address_screen.dart';
import 'package:zaykazone/view/screens/login_page/login_screen.dart';
import 'package:zaykazone/view/screens/onboarding/on_boarding_screen.dart';
import 'package:zaykazone/view/screens/orders/order_screen.dart';
import 'package:zaykazone/view/screens/payment/my_card_screen.dart';
import 'package:zaykazone/view/screens/phone_otp_screen/otp_screen/phone_otp_screen.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';
import 'package:zaykazone/view/screens/profile/chat_support_screen.dart';
import 'package:zaykazone/view/screens/profile/contact_us_screen.dart';
import 'package:zaykazone/view/screens/profile/faqs_screen.dart';
import 'package:zaykazone/view/screens/profile/favourite_screen.dart';
import 'package:zaykazone/view/screens/profile/help_support_screen.dart';
import 'package:zaykazone/view/screens/profile/notification_screen.dart';
import 'package:zaykazone/view/screens/profile/offers_screen.dart';
import 'package:zaykazone/view/screens/profile/privacy_policy_screen.dart';
import 'package:zaykazone/view/screens/profile/rating_and_review.dart';
import 'package:zaykazone/view/screens/profile/wallet_screen.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<LoginProvider>(context);
    final imageUrl = provider.userData?["user_pic"];

    return Scaffold(
      backgroundColor: const Color(0xff0F2027), 
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
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 80,
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                    child: const FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassContainer(
                      borderRadius: 20,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: w * 0.10,
                            backgroundImage: (imageUrl != null &&
                                    imageUrl.isNotEmpty &&
                                    imageUrl != "null")
                                ? NetworkImage(imageUrl)
                                : const AssetImage("assets/images/user.png")
                                    as ImageProvider,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.userData?["name"] ?? "User Name",
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  provider.userData?["email"] ??
                                      "useremail@gmail.com",
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "I like fast food",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => provider.editProfile(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.03),
                    profileCategory(
                      title: "Personal Information",
                      icon: Icons.person,
                      iconColor: Colors.blue,
                      children: [
                        buildOption(
                          icon: Icons.home,
                          text: "Address",
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.credit_card,
                          text: "My Cards",
                          color: Colors.deepPurple,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyCardsScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "My Orders",
                      icon: CupertinoIcons.cart_fill,
                      iconColor: Color(0xffFF620D),
                      children: [
                        buildOption(
                          icon: Icons.list_alt,
                          text: "Orders",
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.favorite_border,
                          text: "Favourite",
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavouriteScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.location_pin,
                          text: "Track Order",
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackOrderScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "Notifications",
                      icon: Icons.notifications_active,
                      iconColor: Colors.deepPurple,
                      children: [
                        buildOption(
                          icon: Icons.notifications,
                          text: "Alerts",
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.discount,
                          text: "Offers & Coupons",
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OffersScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "Reviews & Ratings",
                      icon: CupertinoIcons.star_fill,
                      iconColor: Color(0xd5ff620d),
                      children: [
                        buildOption(
                          icon: Icons.rate_review,
                          text: "Add Review",
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddReviewScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.star_half,
                          text: "Rating And Reviews",
                          color: Color(0xffFF620D),
                          onTap: () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRatingScreen(),),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "Wallet",
                      icon: Icons.account_balance_wallet,
                      iconColor: Colors.green,
                      children: [
                        buildOption(
                          icon: Icons.account_balance_wallet,
                          text: "My Wallet",
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WalletScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "Help & Support",
                      icon: CupertinoIcons.question_circle,
                      iconColor: Colors.redAccent,
                      children: [
                        buildOption(
                          icon: Icons.question_answer,
                          text: "FAQs",
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FAQScreen()),
                          ),
                        ),
                        buildOption(
                          icon: Icons.support_agent,
                          text: "Help & Support",
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpSupportScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.chat,
                          text: "Live Chat Support",
                          color: Color(0xffFF620D),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveChatSupportScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                          icon: Icons.phone,
                          text: "Contact Us",
                          color: Colors.purple,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactUsScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    profileCategory(
                      title: "Settings",
                      icon: Icons.settings,
                      iconColor: Colors.black,
                      children: [
                        buildOption(
                          icon: Icons.privacy_tip,
                          text: "Privacy Policy",
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen(),
                            ),
                          ),
                        ),
                        buildOption(
                            icon: Icons.logout,
                            text: "Log Out",
                            color: Colors.red,
                            showArrow: false,
                            onTap: showAlertDialog),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          deleteAccountAlertDialog();
                        },
                        child: const Text(
                          "Delete Account",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileCategory({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return GlassContainer(
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 26, color: iconColor),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(children: children),
        ],
      ),
    );
  }

  Widget buildOption({
    required IconData icon,
    required String text,
    required Color color,
    bool showArrow = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            if (showArrow)
              const Icon(
                CupertinoIcons.forward,
                color: Colors.white70,
              ),
          ],
        ),
      ),
    );
  }

  Future showAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.85),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("LogOut !", style: TextStyle(color: Colors.red)),
          content: Text("Are you sure you want to logout ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                final provider =
                    Provider.of<LoginProvider>(context, listen: false);

                await provider.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                "LogOut",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }

  Future deleteAccountAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.85),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Account Alert !", style: TextStyle(color: Colors.red)),
          content: Text("Are you sure you want to delete your Account ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                final provider =
                    Provider.of<LoginProvider>(context, listen: false);

                final success = await provider.deleteAccount();

                if (success) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => OnBoardingScreen()),
                    (route) => false,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to delete account")),
                  );
                }
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
