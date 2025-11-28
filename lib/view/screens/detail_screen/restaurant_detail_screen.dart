import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';
import 'package:zaykazone/model/users/restaurant_details_modal.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantDetailsModal restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var provider = Provider.of<RestaurantDetailsProvider>(context);
    var image=widget.restaurant.image_url;
    var name=widget.restaurant.name;
    var des=widget.restaurant.description;
    var food=widget.restaurant.food_details;
    var time=widget.restaurant.delivery_time;
    var charge=widget.restaurant.delivery_charge;
    var rating=widget.restaurant.rating;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFF620D),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                    size: 20, color: Colors.black),
              ),
            ),
          ),
          title: Column(
            children: [
              Text("Restaurant", style: TextStyle(fontSize: 18)),
              Text("Details Screen",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ],
          ),
        ),

        backgroundColor: Colors.white,


        body: ListView(children: [
          SizedBox(height: height*0.002,),
          ClipRRect(
            //borderRadius: BorderRadius.circular(15), // Rounded Corners
            child: Image.network(
              "https://zaykazone-project-api.onrender.com/uploads/$image",
              height: height*0.4,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:height*0.01),
                Text(name ?? "", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffFF620D),),),
                SizedBox(height:height*0.01),
                Text(des ?? "", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black45,),),
                SizedBox(height:height*0.02),
                Text(food ?? "", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height:height*0.02),
                Row(children: [
                  Icon(Icons.star,color: Color(0xffFF620D),),
                  SizedBox(width:width*0.05),
                  //Text(rating!),
                  Icon(Icons.delivery_dining,color: Color(0xffFF620D),),
                  SizedBox(width:width*0.02),
                  Text(charge!),
                  SizedBox(width:width*0.05),
                  Icon(Icons.watch_later_outlined,color: Color(0xffFF620D),size: 20,),
                  SizedBox(width:width*0.02),
                  Text(time!),



                ],)

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF620D), // Orange theme
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 6,
                shadowColor: Colors.orangeAccent,
              ),
              child: Text(
                "View Menu",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )


        ],),



      ),
    );
  }
}
