import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    double fieldWidth = (w - 50) / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.28,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/img_2.png",
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: h * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xffFF620D)),
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Street",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Pin Code",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Apartment / Flat No.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xffFF620D), width: 1.5),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              Padding(
                padding: EdgeInsets.only(left: w * 0.05),
                child: Text(
                  "Label as",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: h * 0.015),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labelButton("Home", 0),
                    labelButton("Work", 1),
                    labelButton("Other", 2),
                  ],
                ),
              ),

              SizedBox(height: h * 0.08),

              Center(
                child: SizedBox(
                  width: w * 0.85,
                  height: h * 0.058,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF620D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Save Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelButton(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        height: 45,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffFF620D) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? Color(0xffFF620D) : Colors.grey),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
