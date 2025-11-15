import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ProfileScreen() ,
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
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: Icon(CupertinoIcons.back),
          title: Text("Profile"),
        ),
        body: Column(
           children: [
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: CircleAvatar(
                     radius: 35,
                     child: Text("H Q"),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 20),
                   child: Text("Hena Quamar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 120,top: 30),
                   child: Icon(Icons.home),
                 )
               ],
             ),
             Text("data")
           ],
          
        ),

    );
  }
}

