import 'dart:ui';

import 'package:flutter/material.dart';

class SpicyScreen extends StatefulWidget {
  const SpicyScreen({super.key});

  @override
  State<SpicyScreen> createState() => _SpicyScreenState();
}

class _SpicyScreenState extends State<SpicyScreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    int selectedIndex=0;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,top: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 200),
                  child: Text("Spicy Restaurant",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 25),
            child: Container(
              width: width,
              height: height*0.25,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset("asset/img_6.png",fit: BoxFit.cover,),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Text("Spicy Restaurant",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
          ),
        Padding(
          padding: EdgeInsets.only(left: 20,top: 10),
          child: Column(
            children: [
              Text("Restaurant details typically include the cuisine, almosphere."),
              Text("and location to help customers decide where to eat, Other"),
              Text("important details are the"),
            ],
          ),
        ),

          Padding(
            padding: const EdgeInsets.only(left: 20,top: 15),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: 100,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isselected=index==selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: width*0.15,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),border: Border.all(width: 2,color: Colors.grey),
                          color: isselected ? Colors.orange :Colors.white),
                      child: Center(child: Text("Burger",style: TextStyle(color: isselected ? Colors.white : Colors.grey),)),
                    ),
                  );
                },),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Text("Burger (10)",style: TextStyle(fontSize: 17),),
          ),

          Expanded(
            child: ListView.builder(
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20,top: 15),
                      height: height*0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),color: Colors.grey
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(child: Image.asset("asset/img_7.png",width: 100,height: 100,)),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text("Burger Bistro",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text("Rose Garden",style: TextStyle(fontSize: 17)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25,top: 10),
                                  child: Text("&40",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,top: 10),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.orange,
                                    child: Icon(Icons.add,size: 17,color: Colors.white,),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20,top: 15),
                      height: height*0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),color: Colors.grey
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(child: Image.asset("asset/img_7.png",width: 100,height: 100,)),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text("Burger Bistro",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text("Rose Garden",style: TextStyle(fontSize: 17)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25,top: 10),
                                  child: Text("&40",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,top: 10),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.orange,
                                    child: Icon(Icons.add,size: 17,color: Colors.white,),
                                  ),
                                )
                              ] ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                ],
              );
            },),
          )

        ],
      ),
    );
  }
}
