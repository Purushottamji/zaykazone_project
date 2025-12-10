import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/view/screens/address/address_screen.dart';
import 'package:zaykazone/view/screens/editAdrees/editAdress_screen.dart';
import 'package:zaykazone/view/screens/edit_profile/edit_profile.dart';
import 'package:zaykazone/view/screens/login_page/login_screen.dart';
import 'package:zaykazone/view/screens/orders/order_screen.dart';
import 'package:zaykazone/view/screens/payment/my_card_screen.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';
import 'package:zaykazone/view/screens/profile/chat_support_screen.dart';
import 'package:zaykazone/view/screens/profile/contact_us_screen.dart';
import 'package:zaykazone/view/screens/profile/faqs_screen.dart';
import 'package:zaykazone/view/screens/profile/favourite_screen.dart';
import 'package:zaykazone/view/screens/profile/help_support_screen.dart';
import 'package:zaykazone/view/screens/profile/my_review_screen.dart';
import 'package:zaykazone/view/screens/profile/notification_screen.dart';
import 'package:zaykazone/view/screens/profile/offers_screen.dart';
import 'package:zaykazone/view/screens/profile/privacy_policy_screen.dart';
import 'package:zaykazone/view/screens/profile/wallet_screen.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';
import '../../../utils/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? profileImage;

  get id => null;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => SizedBox(
            height: 130,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () async {
                    final picked = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      setState(() => profileImage = File(picked.path));
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () async {
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      setState(() => profileImage = File(picked.path));
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<LoginProvider>(context);
    final imageUrl = provider.userData != null &&
        provider.userData!["user_pic"] != null
        ? "${AppConstants.baseUrl}/uploads/user_pic/${provider.userData!["user_pic"]}"
        : null;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF620D),
        automaticallyImplyLeading: false,
        title: const Text("Profile", style: TextStyle(color: Colors.white,fontSize: 20)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: w * 0.10,
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                      backgroundColor: const Color(0x80ff620d),
                      child: imageUrl == null
                          ? Icon(Icons.camera_alt, size: w * 0.08)
                          : null,
                    ),
                  ),
                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.userData?["name"] ?? "Hena Quamer",
                          style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          provider.userData?["email"] ?? "purushotam@gmail.com",
                          style: TextStyle(
                            fontSize: w * 0.035,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "I like fast food",
                              style: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {
                   provider.editProfile(context);
                  }, icon: Icon(Icons.edit,color: Colors.red,))
                ],
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavouriteScreen(userId: id,),
                          ),
                        ),
                  ),
                  buildOption(
                    icon: Icons.location_pin,
                    text: "Track Order",
                    color: Colors.green,
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReviewScreen(),
                          ),
                        ),
                  ),
                  buildOption(
                    icon: Icons.star_half,
                    text: "Restaurant Rating",
                    color: Color(0xffFF620D),
                    onTap:
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Restaurant Rating")),
                        ),
                  ),
                  buildOption(
                    icon: Icons.reviews,
                    text: "My Reviews",
                    color: Colors.blue,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyReviewsScreen(),
                          ),
                        ),
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalletScreen(),
                          ),
                        ),
                  ),
                  buildOption(
                    icon: Icons.list_alt,
                    text: "Transactions",
                    color: Color(0xffFF620D),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpSupportScreen(),
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQScreen()),
                        ),
                  ),
                  buildOption(
                    icon: Icons.support_agent,
                    text: "Help & Support",
                    color: Colors.green,
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap:
                        () => Navigator.push(
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
                    onTap: showAlertDialog
                  ),
                ],
              ),

              SizedBox(height: 30),
            ],
          ),
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
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: iconColor),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 15),
            Column(children: children),
          ],
        ),
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
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 25, color: color),
                SizedBox(width: 15),
                Text(text, style: TextStyle(fontSize: 17)),
              ],
            ),
            if (showArrow) Icon(CupertinoIcons.forward, size: 22),
          ],
        ),
      ),
    );
  }

  Future showAlertDialog() {
    return showDialog(context: context, builder: (context) {
     return AlertDialog(
       backgroundColor: Colors.white,
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
            onPressed: () {
              Provider.of<LoginProvider>(context,listen: false).logout(context);
            },
            child: Text("LogOut", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },);
  }
}
