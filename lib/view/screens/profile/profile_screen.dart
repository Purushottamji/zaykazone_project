import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? profileImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: 160,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.black),
              title: Text("Camera"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() => profileImage = File(picked.path));
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: Colors.black),
              title: Text("Gallery"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
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

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: Text("Profile", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- PROFILE HEADER ----------------
              Row(
                children: [
                  InkWell(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: w * 0.12,
                      backgroundImage:
                      profileImage != null ? FileImage(profileImage!) : null,
                      backgroundColor: Colors.orangeAccent.shade100,
                      child: profileImage == null
                          ? Icon(Icons.camera_alt, size: w * 0.08)
                          : null,
                    ),
                  ),
                  SizedBox(width: w * 0.04),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hena Quamar",
                        style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "I like fast food",
                        style: TextStyle(fontSize: w * 0.035, color: Colors.black54),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.home, size: w * 0.07),
                ],
              ),

              SizedBox(height: h * 0.03),

              // ---------------- MENU CARDS ----------------
              profileCard(
                icon: Icons.account_circle,
                iconColor: Colors.orangeAccent,
                title: "Personal Information",
                options: [
                  buildOption(
                    icon: CupertinoIcons.home,
                    text: "Address",
                    color: Colors.blue,
                  ),
                ],
              ),

              SizedBox(height: 20),

              profileCard(
                icon: CupertinoIcons.cart,
                iconColor: Colors.orangeAccent,
                title: "My Order",
                options: [
                  buildOption(
                    icon: Icons.favorite_border,
                    text: "Favourite",
                    color: Colors.red,
                  ),
                ],
              ),

              SizedBox(height: 20),

              profileCard(
                icon: Icons.notifications_none_outlined,
                iconColor: Colors.black,
                title: "Notifications",
                options: [
                  buildOption(
                    icon: Icons.payment,
                    text: "Payment Method",
                    color: Colors.deepPurple,
                  ),
                ],
              ),

              SizedBox(height: 20),

              profileCard(
                icon: CupertinoIcons.question_circle,
                iconColor: Colors.orangeAccent,
                title: "FAQs",
                options: [
                  buildOption(
                    icon: Icons.reviews,
                    text: "User Reviews",
                    color: Colors.orangeAccent,
                  ),
                ],
              ),

              SizedBox(height: 20),

              profileCard(
                icon: Icons.settings,
                iconColor: Colors.blue,
                title: "Settings",
                options: [
                  buildOption(
                    icon: Icons.logout,
                    text: "Log Out",
                    color: Colors.redAccent,
                    showArrow: false,
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

  // ------------------- REUSABLE WIDGETS -------------------

  Widget profileCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Widget> options,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            // Main Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 27, color: iconColor),
                    SizedBox(width: 15),
                    Text(title, style: TextStyle(fontSize: 17)),
                  ],
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14),
                  child: Icon(CupertinoIcons.back, size: 22),
                ),
              ],
            ),

            SizedBox(height: 20),
            // Options List
            Column(children: options),
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
  }) {
    return Padding(
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
    );
  }
}
