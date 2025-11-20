import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/address/address_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: const Icon(CupertinoIcons.back),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/img_1.png"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Enter your name",
                  ),
                ),

                const SizedBox(height: 20),


                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Enter your email",
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_enabled),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Enter your Phone number",
                  ),
                ),

                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Enter your bio",
                  ),
                ),

                const SizedBox(height: 20),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(),));
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
