import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/restaurant_details_provider/restaurant_provider.dart';

class AddRestaurantScreen extends StatelessWidget {
  const AddRestaurantScreen({super.key});

  void openBottomSheet(BuildContext context) {
    final restProvider = Provider.of<RestaurantProvider>(context, listen: false);

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.deepOrange),
                title: Text("Pick From Gallery", style: TextStyle(fontSize: 16)),
                onTap: () {
                  restProvider.pickFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.deepOrange),
                title: Text("Pick From Camera", style: TextStyle(fontSize: 16)),
                onTap: () {
                  restProvider.pickFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth= MediaQuery.of(context).size.width;
    final screenHeight= MediaQuery.of(context).size.height;
    final restProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Image Picker",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFF620D),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: screenHeight*0.05),


              GestureDetector(
                onTap: () => openBottomSheet(context),
                child: Container(
                  height: screenHeight * 0.30,
                  width: screenWidth * 0.70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: restProvider.imageFile == null
                        ? Center(child: Icon(Icons.person, size: 100, color: Colors.grey.shade600))
                        : Image.file(restProvider.imageFile!, fit: BoxFit.cover),
                  ),
                ),
              ),

              SizedBox(height: screenHeight*0.03),


              TextFormField(
                decoration: InputDecoration(
                  labelText: "Restaurant name",
                  hintText: "Enter restaurant name",
                  prefixIcon: Icon(Icons.store),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Restaurant description",
                  hintText: "Enter description",
                  prefixIcon: Icon(Icons.description),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Restaurant food_details",
                  hintText: "Enter food items",
                  prefixIcon: Icon(Icons.food_bank),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Restaurant address",
                  hintText: "Enter address",
                  prefixIcon: Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),

              SizedBox(height: 25),


              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF620D),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Submit",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
