import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text("Help & Support"),
          centerTitle: true,
          elevation: 0,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                decoration: InputDecoration(
                  hintText: "Search help topics...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Quick Help",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 110,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    quickAction(Icons.help_outline, "FAQs"),
                    quickAction(Icons.chat, "Live Chat"),
                    quickAction(Icons.phone, "Call Us"),
                    quickAction(Icons.wallet, "Refund"),
                    quickAction(Icons.local_shipping, "Order Issue"),
                    quickAction(Icons.discount, "Coupons"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Popular Topics",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView(
                  children: [
                    topicTile("Order not delivered"),
                    topicTile("Payment failed"),
                    topicTile("Refund not received"),
                    topicTile("Account issues"),
                    topicTile("App not working"),
                    topicTile("Coupons not applying"),
                    topicTile("Delivery partner issue"),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.support_agent),
            label: const Text("Chat with Support"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget quickAction(IconData icon, String title) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  // 🔹 Topic ListTile
  Widget topicTile(String title) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
