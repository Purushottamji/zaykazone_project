import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/cart/add_cart_screen.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(height: 112,width: 112,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: AssetImage("assets/images/img_6.png"),fit: BoxFit.fill,),),),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(children: [


                  Text("Uttora Food House",style: TextStyle(fontSize: 19),),
                  Text("Orderd At 06 Sep, 10:00 pm\n2x Burger\n4x Sanwitch"),


                                ],),
                )

            ],),
          ),);


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
