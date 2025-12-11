import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/user_address_provider/user_address_provider.dart';
import '../../../model/user_address_model/user_address_model.dart';

class EditAddressScreen extends StatefulWidget {
  final UserAddressModel? existingAddress;   // null = add mode

  const EditAddressScreen({super.key, this.existingAddress});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  int selectedIndex = 0; // Home = 0, Work = 1, Other = 2

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<UserAddressProvider>(context, listen: false);

    // If editing, pre-fill data
    if (widget.existingAddress != null) {
      provider.setAddressData(widget.existingAddress!);

      selectedIndex =
          provider.getIndexFromLabel(widget.existingAddress!.labelAs);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final provider = Provider.of<UserAddressProvider>(context);

    double fieldWidth = (w - 50) / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BANNER IMAGE
              SizedBox(
                height: h * 0.28,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/img_2.png",
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 20),

              // ADDRESS FIELD
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: TextFormField(
                  controller: provider.addressController,
                  decoration: InputDecoration(
                    labelText: "Full Address",
                    prefixIcon: const Icon(Icons.location_on_outlined,
                        color: Color(0xffFF620D)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              // STREET + PINCODE ROW
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        controller: provider.streetController,
                        decoration: InputDecoration(
                          labelText: "Street",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        controller: provider.pinController,
                        decoration: InputDecoration(
                          labelText: "Pin Code",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // BUILDING + FLAT NO
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        controller: provider.buildingNoController,
                        decoration: InputDecoration(
                          labelText: "Building No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        controller: provider.flatNoController,
                        decoration: InputDecoration(
                          labelText: "Apartment / Flat",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              Padding(
                padding: EdgeInsets.only(left: w * 0.05),
                child: Text(
                  "Label as",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.045,
                  ),
                ),
              ),

              SizedBox(height: 10),

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

              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: w * 0.85,
                  height: h * 0.058,
                  child: ElevatedButton(
                    onPressed: () async {
                      String selectedLabel =
                      provider.getLabelFromIndex(selectedIndex);
                      bool result;
                      if (widget.existingAddress == null) {
                        result = await provider.saveAddress(selectedLabel);
                      } else {
                        result = await provider.updateAddress(
                            widget.existingAddress!.addId, selectedLabel);
                      }

                      if (result) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF620D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.existingAddress == null
                          ? "Save Address"
                          : "Update Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
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
          border: Border.all(
              color: isSelected ? Color(0xffFF620D) : Colors.grey),
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
