import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
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
                Text("Search",style: TextStyle(color: Colors.white,fontSize: 15),),
              ],
            )
          ],
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 10),
            child: TextFormField(decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search Dishes, restaurant",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Row(
              children: [
                Text("Recent Keywords",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
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
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: width*0.15,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),border: Border.all(width: 2,color: Colors.grey)),
                      child: Center(child: Text("Burger")),
                    ),
                  );
                },),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20,top: 20),
            child: Row(
              children: [
                Text("Suggested Restaurants",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
              ],
            ),
          ),
          SizedBox(
            height: height*0.42,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 10),
                    width: width*0.2,
                    height: height*0.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.red),
                    child: Image.asset("asset/img_2.png",fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pansi Restaurant"),
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(Icons.star_border_outlined,size: 20,color: Colors.orange,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("4.7",style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                          ),
                          
                        ],
                      ),
                      

                    ],
                  ),
                ],
              );
            }, separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Divider(
                  height: 1,
                  thickness: 5,
                  color: Colors.grey,
                ),
              );
            },
              itemCount: 3,
            ),
          ),
         ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Popular Fast Food",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20,right: 10),
                            width: width*0.40,
                            height: height*0.3,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey),
                              child: Column(
                                children: [
                                  Image.asset("asset/img_3.png",width: width*0.3,height: height*0.2,),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text("European Pizza",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text("uttora Coffee House",style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          width: width*0.40,
                          height: height*0.3,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey),
                          child: Column(
                            children: [
                              Image.asset("asset/img_3.png",width: width*0.3,height: height*0.2,),
                              SizedBox(
                                height: 16,
                              ),
                              Text("European Pizza",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text("uttora Coffee House",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),

                      )
                    ],
                  )
                ],
              );
            },),

        ],
      ),
    );
  }
}
