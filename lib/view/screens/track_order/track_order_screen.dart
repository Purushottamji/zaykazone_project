import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("TrackOrder"),backgroundColor: Color(0xffd5dde0),),
    body:
    Stack(children: [
      SizedBox(width: screenWidth*10,height: screenHeight*10,
        child: Image(image: AssetImage("assets/images/img_5.png"),fit: BoxFit.fill,),),
      Padding(
        padding: const EdgeInsets.only(top: 530,left: 100),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffFF7622),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(
                Radius.circular(10),
              ),
            ),
          ),
          onPressed: () {

        showModalBottomSheet(context: context, builder: (context) {
          return SizedBox(height: screenHeight*0.25,
          child: Row(children: [
            Image(image: AssetImage("assets/images/img_6.png"),width: 100,height: 100,),
            Column(children: [
              Text("data"),
              Text("data"),
              Text("data"),

            ],)
            
          ],),);


        },);
          },
          child: Text("PAY & CONFIRM", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],)
    ),
    );

  }
}
