import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Address"),
        backgroundColor: Color(0xffFF620D),
        elevation: 0,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AddressTile(
                  label: "HOME",
                  icon: Icons.home,
                  address: "Amnour, Parsa Saran",
                ),

                AddressTile(
                  label: "WORK",
                  icon: Icons.work,
                  address: "Patna, Digha bridge halt",
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 15),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
    );
  }
}


class AddressTile extends StatelessWidget {
  final String label;
  final String address;
  final IconData icon;

  const AddressTile({
    super.key,
    required this.label,
    required this.address,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
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
          Icon(icon, color: Color(0xffFF620D), size: w * 0.07),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(fontSize: w * 0.04, color: Colors.black87),
                ),
              ],
            ),
          ),

          Row(
            children: const [
              Icon(Icons.edit, color: Colors.green),
              SizedBox(width: 12),
              Icon(Icons.delete, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
