import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/cart/add_cart_screen.dart';
import 'package:zaykazone/view/screens/payment/case_study_screen.dart';
import 'package:zaykazone/view/screens/track_order/track_order_screen.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("PaymentScreen"),),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(children: [
        SingleChildScrollView(scrollDirection: Axis.horizontal,
          child: Row(
            children: [
           Column(children: [
             Container(width: screenWidth*0.23,height: screenHeight*0.10,decoration: BoxDecoration(color: Color(0xffECEDEF),borderRadius: BorderRadius.circular(10)),
               child:
               ClipRRect(borderRadius: BorderRadius.circular(10),
                 child: Icon(Icons.cases_rounded,color: Color(0xffFF7622),size: 30,),),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 22),
               child: Text("Cash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
             ),

           ],),
              SizedBox(width: 10,),
              Column(children: [
             Container(width: screenWidth*0.23,height: screenHeight*0.10,decoration: BoxDecoration(color: Color(0xffECEDEF),borderRadius: BorderRadius.circular(10)),
               child:
               ClipRRect(borderRadius: BorderRadius.circular(10),
                 child: Icon(Icons.supervisor_account,color: Color(0xffFF7622),size: 30,),),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 22),
               child: Text("Visa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
             ),


           ],),
              SizedBox(width: 10,),
              Column(children: [
                SizedBox(width: 10,),
             Container(width: screenWidth*0.23,height: screenHeight*0.10,decoration: BoxDecoration(color: Color(0xffECEDEF),borderRadius: BorderRadius.circular(10)),
               child:
               ClipRRect(borderRadius: BorderRadius.circular(10),
                 child: Icon(Icons.cases_rounded,color: Color(0xffFF7622),size: 30,),),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 22),
               child: Text("Cash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
             ),

           ],),
              SizedBox(width: 10,),
              Column(children: [
             Container(width: screenWidth*0.23,height: screenHeight*0.10,decoration: BoxDecoration(color: Color(0xffECEDEF),borderRadius: BorderRadius.circular(10)),
               child:
               ClipRRect(borderRadius: BorderRadius.circular(10),
                 child: Icon(Icons.cases_rounded,color: Color(0xffFF7622),size: 30,),),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 22),
               child: Text("Cash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
             ),

           ],),

          ],),),

        SizedBox(height: 20,),
        Container(height: screenHeight*0.30,decoration: BoxDecoration(color: Color(0xffECEDEF),borderRadius: BorderRadius.circular(10)),
          child:
          ClipRRect(borderRadius: BorderRadius.circular(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Image(image: AssetImage("assets/images/img_3.png"),width: 130,height: 130,),
              Expanded(
                child: TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCartScreen(),));

                }, child: Text(" No master card addedYou can add\n   a mastercard andsave it for later",style: TextStyle(color:Colors.black),)),
              )
            ],)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFFF0F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCartScreen(),));


            },
            child: Text(
              "+ ADD NEW",
              style: TextStyle(color: Color(0xffFF7622)),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Text("TOTAL: 96",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFF7622),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {

             Navigator.push(context, MaterialPageRoute(builder: (context) => CaseStudyScreen(),));
            },
            child: Text("PAY & CONFIRM", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],),
    ),));
  }
}
