import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _glassAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: addProvider.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffFF620D),
                  ),
                )
                    : addProvider.userAddress.isEmpty
                    ? Center(
                  child: Text(
                    "No Address Found",
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: () =>
                      addProvider.fetchUserAddress(),
                  color: const Color(0xffFF620D),
                  child: ListView.builder(
                    itemCount: addProvider.userAddress.length,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      final data =
                      addProvider.userAddress[index];
                      return _glassAddressCard(
                          context, addProvider, data);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffFF620D),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Address"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const EditAddressScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _glassAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xffFF620D).withOpacity(0.60),
            border: Border(
              bottom:
              BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: const [
                Text(
                  "My Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassAddressCard(
      BuildContext context,
      UserAddressProvider addProvider,
      data,
      ) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xffFF620D).withOpacity(0.4),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xffFF620D),
                  size: w * 0.08,
                ),
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
                          color: Colors.white,
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
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Colors.green),
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
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.red),
                      onPressed: () =>
                          _deleteDialog(context, addProvider, data),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteDialog(
      BuildContext context, UserAddressProvider provider, data) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Delete!",
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          "Are you sure you want to delete your ${data.labelAs} address?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
            const Text("No", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () async {
              await provider.removeAddress(data.addId);
              Navigator.pop(context);
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Color(0xffFF620D)),
            ),
          ),
        ],
      ),
    );
  }
}

