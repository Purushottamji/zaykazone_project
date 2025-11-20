import 'package:flutter/material.dart';

class BurgerScreen extends StatefulWidget {
  const BurgerScreen({super.key});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange.shade400,
                ),
                child: Image.asset("asset/img_5.png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 20),
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.heart_broken),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      "Burger Bistro",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          child: Image.asset("asset/img_4.png"),
                        ),
                        SizedBox(width: 15),
                        Text("Rose Garden"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: 22,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "4.7",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.picture_as_pdf,
                          size: 22,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Free",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.picture_as_pdf,
                          size: 22,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "20 min",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15,top: 10),
                    child: Text("Maecenas sed diam eget risus varius blandit sit", style: TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis,),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,top: 3),
                    child: Text("amet non magna. Integer posuere erat a ante", style: TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis,),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,top: 3),
                    child: Text("venenatis dopibus possuere velit aliquet.", style: TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis,),),
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
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
               SizedBox(
                 height: 50,
                 width: width,
                 child: ListView.builder(
                  itemCount: 100,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ),
                    );
                 },),
               ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 25),
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
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                              child: ElevatedButton(onPressed: () {
                              }, child: Text("ADD TO CART",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
