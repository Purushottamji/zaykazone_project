import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  List<Map<String,dynamic>> address=[
    {
      "label":"HOME",
      "icon":Icons.home,
      "address":"Amnour, Parsa Saran"
    },
    {
      "label":"WORK",
      "icon":Icons.work,
      "address":"Patna, Digha bridge halt"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
              child: ListView.builder(itemCount: address.length,
                itemBuilder: (context, index) {
                var data=address[index];
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
                                data["address"],
                                style: TextStyle(fontSize: w * 0.04, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 100,
                          child: Row(
                            children:  [
                              IconButton(onPressed: () {

                              }, icon: Icon(Icons.edit, color: Colors.green),),
                              IconButton(onPressed: () {

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

