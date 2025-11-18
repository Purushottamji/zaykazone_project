import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: Icon(CupertinoIcons.back),
        title: Text("Profile"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    radius: 35,
                    child: Text("H Q"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hena Quamar",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text("I like fast food"),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(CupertinoIcons.home),
                ),
              ],
            ),

            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_circle, size: 27,color: Colors.orangeAccent,),
                            SizedBox(width: 15),
                            Text(
                              "Personal Information",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: Icon(CupertinoIcons.back, size: 22),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.home,size: 25,color: Colors.blue,),
                            SizedBox(width: 15),
                            Text(
                              "Address",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Icon(CupertinoIcons.forward, size: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.cart, size: 25,color: Colors.orangeAccent,),
                            SizedBox(width: 15),
                            Text(
                              "My Order",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: Icon(CupertinoIcons.back, size: 22),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border,color: Colors.red,),
                            SizedBox(width: 15),
                            Text("Favourite", style: TextStyle(fontSize: 17),),
                          ],
                        ),
                        Icon(CupertinoIcons.forward, size: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications_none_outlined, size: 27),
                            SizedBox(width: 15),
                            Text(
                              "Notifications",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: Icon(CupertinoIcons.back, size: 22),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.payment,size: 27,color: Colors.deepPurple,),
                            SizedBox(width: 15),
                            Text("Payment Method", style: TextStyle(fontSize: 17),),
                          ],
                        ),
                        Icon(CupertinoIcons.forward, size: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.f_cursive_circle, size: 27,color: Colors.orangeAccent,),
                            SizedBox(width: 15),
                            Text(
                              "FAQs",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: Icon(CupertinoIcons.back, size: 22),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.reviews,size: 27,color: Colors.orangeAccent,),
                            SizedBox(width: 15),
                            Text("User Reviews", style: TextStyle(fontSize: 17),),
                          ],
                        ),
                        Icon(CupertinoIcons.forward, size: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.settings, size: 27,color: Colors.blue,),
                            SizedBox(width: 15),
                            Text(
                              "Settings",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14),
                          child: Icon(CupertinoIcons.back, size: 22),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.logout,color: Colors.orangeAccent,size: 25),
                            SizedBox(width: 15),
                            Text("Log Out", style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
