import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.only(left: 15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
              )
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Details",style: TextStyle(color: Colors.white,fontSize: 15),),
              ],
            )
          ],
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 50),
                width: double.infinity,
                height: height*0.2,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.orange.shade400),
              ),
              Positioned(
                  right: 30,
                  bottom: 20,
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.heart_broken_sharp),
                  )
              ),
              Positioned(
                  top: 15,
                  left: 120,
                  right: 120,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset("asset/img_3.png",fit: BoxFit.contain,)))
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,top: 20),
                width: width*0.5,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.grey,border:Border.all(color: Colors.black,width: 2)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        child: Image.asset("asset/img_4.png"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Uttara Coffee House",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,color: Colors.white),)
                    ],
                  )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Pizza Calzone European",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                   Text("Prosciutto e fought is a pizza variety that is",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                   Text("topped with tomato source.",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                 ],
               )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Row(
              children: [
                Icon(Icons.star_border_outlined,size: 25,color: Colors.orange,),
                SizedBox(
                  width: 10,
                ),
                Text("4.7",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.picture_as_pdf,size: 25,color: Colors.orange,),
                SizedBox(
                  width: 10,
                ),
                Text("Free",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.picture_as_pdf,size: 25,color: Colors.orange,),
                SizedBox(
                  width: 10,
                ),
                Text("20 min",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 20),
            child: Row(
              children: [
                Text("SIZE:"),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                 child: Text("10 '"),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text("14 '"),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  child: Text("16 '"),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Row(
              children: [
                Text("INGRIDENTS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
              ],
            ),
          ),
          SizedBox(
              height: height*0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: 100,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                  );
                },),
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.grey),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10),
                        child: Text("& 32",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20,top: 10),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Text("-"),
                                ),
                              ),
                              Text("2",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Text("+"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                       Expanded(
                         child: SizedBox(width: double.infinity,
                           height: 45,
                           child: Padding(
                             padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                             child: ElevatedButton(onPressed: () {
                                },style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("ADD TO CART",style: TextStyle(color: Colors.white),),),
                           ),
                         ),
                       ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
