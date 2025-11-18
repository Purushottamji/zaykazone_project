import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';

class CaseStudyScreen extends StatefulWidget {
  const CaseStudyScreen({super.key});

  @override
  State<CaseStudyScreen> createState() => _CaseStudyScreenState();
}

class _CaseStudyScreenState extends State<CaseStudyScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(appBar: AppBar(title:Text("CaseStudyScreen"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: ListView(children: [
         SizedBox(height: 40,),
          Container(
            height: screenHeight*0.25,width: screenWidth*0.25,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
            child: ClipRRect(borderRadius: BorderRadius.circular(15),
                child: Image(image: AssetImage("assets/images/img_2.png"),fit: BoxFit.fill,)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 30),
            child: Text("Congratulations!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ),
          Text("        Your Successfully maked a",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xffA7A0A0)),),
          Text("        paymentenjoy our service!",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xffA7A0A0)),),
          SizedBox(height: 80,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFF620D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrderScreen(),));
            },
            child: Text(
              "TRACK ORDER",
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],),
      ),));
  }
}
