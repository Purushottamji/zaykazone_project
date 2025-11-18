import 'package:flutter/material.dart';
class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("Add Cart"),),
      body:ListView(children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(decoration: InputDecoration(hintText: "Card Holder Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),filled: true,fillColor: Color(0xffECEDEF)),),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(decoration: InputDecoration(hintText: "Card Number",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),filled: true,fillColor: Color(0xffECEDEF)),),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
                 SizedBox(width: 150,
                child: TextFormField(decoration: InputDecoration(hintText: "Expire Date",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),filled: true,fillColor: Color(0xffECEDEF)),)),
               Spacer(),
                SizedBox(width: 150,
               child: TextFormField(decoration: InputDecoration(hintText: "cvc",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),filled: true,fillColor: Color(0xffECEDEF)),)),


          ],),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 350,right: 40,left: 40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFF7622),padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(
                  Radius.circular(10),
                ),),),
            onPressed: () {

            },
            child: Text("ADD & MAKE PAYMENT", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ),

      ],) ,));
  }
}

