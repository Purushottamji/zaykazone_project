import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_address/user_address_provider.dart';
import 'package:zaykazone/view/screens/editAdrees/editAdress_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final addProvider=Provider.of<UserAddressProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Address"),
        backgroundColor: Color(0xffFF620D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemCount: addProvider.address.length,
                itemBuilder: (context, index) {
                var data=addProvider.address[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16,top: 15,bottom: 15,right: 5),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(data["icon"], color: Color(0xffFF620D), size: w * 0.07),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["label"],
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${data["address"]}, ${data["street"]}, ${data["flat_no"]}, ${data["pin_code"]}",
                                style: TextStyle(fontSize: w * 0.04, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 100,
                          child: Row(
                            children:  [
                              IconButton(onPressed: () {
                                addProvider.editAddress(addProvider.address.indexOf(data), context);
                              }, icon: Icon(Icons.edit, color: Colors.green),),
                              IconButton(onPressed: () {
                                addProvider.removeAddress(addProvider.address.indexOf(data), context);
                              }, icon: Icon(Icons.delete, color: Colors.red),)

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF620D),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: h * 0.018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "ADD NEW ADDRESS",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

