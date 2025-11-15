import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditadressScreen(),
    );
  }
}

class EditadressScreen extends StatefulWidget {
  const EditadressScreen({super.key});

  @override
  State<EditadressScreen> createState() => _EditadressScreenState();
}

class _EditadressScreenState extends State<EditadressScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    double fieldWidth = (MediaQuery.of(context).size.width - 40) / 2;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [


              Container(
                height: 260,
                width: double.infinity,
                color: Colors.red,
                child: Image.asset(
                  "assets/images/img_2.png",
                  fit: BoxFit.cover,
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("Address"),
                    prefixIcon: Icon(Icons.location_on_outlined,color: Colors.orangeAccent,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Container(
                      width: fieldWidth,
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Street"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(
                      width: fieldWidth,
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Pin Code"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("Appartiment"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(right: 260, top: 15),
                child: Text(
                  "Label as",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Home",
                          style: TextStyle(
                            color: selectedIndex == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Work",
                          style: TextStyle(
                            color: selectedIndex == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedIndex == 2 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Other",
                          style: TextStyle(
                            color: selectedIndex == 2 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  height: 45,
                  width: 340,
                  child: ElevatedButton(
                      onPressed: () {

                  }, style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                      child: Text("Save Location",style:TextStyle(color: Colors.white) ,)),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
