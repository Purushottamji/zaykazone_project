import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/editAdrees/editAdress_screen.dart';
import '../../../controller/user_address_provider/user_address_provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UserAddressProvider>(context, listen: false)
          .fetchUserAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<UserAddressProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Address"),
        backgroundColor: const Color(0xffFF620D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: addProvider.isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xffFF620D)))
            : addProvider.userAddress.isEmpty
            ? Center(
          child: Text(
            "No Address Found",
            style: TextStyle(
              fontSize: w * 0.045,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        )
            : RefreshIndicator(
          onRefresh: () => addProvider.fetchUserAddress(),
          child: ListView.builder(
            itemCount: addProvider.userAddress.length,
            itemBuilder: (context, index) {
              final data = addProvider.userAddress[index];

              return Container(
                padding: const EdgeInsets.all(15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: Color(0xffFF620D), size: w * 0.08),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.labelAs.toUpperCase(),
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            "Full Address: ${data.fullAddress}\n"
                                "Street: ${data.street}\n"
                                "Apartment No: ${data.apartmentNo}\n"
                                "Building No: ${data.buildingNo}\n"
                                "Pin Code: ${data.pinCode}",
                            style: TextStyle(
                              fontSize: w * 0.035,
                              height: 1.4,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 70,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditAddressScreen(
                                    existingAddress: data,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit,
                                color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete !",style: TextStyle(color: Colors.red),),
                                  content: Text("Are you sure you want to delete your ${data.labelAs} address ?"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("No",style: TextStyle(color: Colors.black),)),
                                    TextButton(onPressed: () async{
                                     await addProvider.removeAddress(data.addId);
                                     Navigator.pop(context);
                                    }, child: Text("Yes",style: TextStyle(color: Color(0xffFF620D)),))
                                  ],
                                );
                              },);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditAddressScreen()),
          );
        },
        backgroundColor: Color(0xffFF620D),
        foregroundColor: Colors.white,
        label: const Text("Add Address"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
