import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Contact Us"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.support_agent,
                    size: 100, color: Color(0xffFF620D)),
              ),
            ),

            const SizedBox(height: 24),

            contactCard(
              icon: Icons.call,
              title: "Phone Support",
              subtitle: "+91 98765 43210",
              onTap: () {},
            ),

            contactCard(
              icon: Icons.email_outlined,
              title: "Email Us",
              subtitle: "support@foodapp.com",
              onTap: () {},
            ),

            contactCard(
              icon: Icons.location_on_outlined,
              title: "Our Office",
              subtitle: "123, Food Plaza, Mumbai, India",
              onTap: () {},
            ),

            contactCard(
              icon: Icons.access_time,
              title: "Working Hours",
              subtitle: "Mon - Sun • 9:00 AM - 11:00 PM",
              onTap: () {},
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Send a Message",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  textField("Full Name"),
                  const SizedBox(height: 10),
                  textField("Email"),
                  const SizedBox(height: 10),
                  textField("Message", maxLines: 4),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.deepPurple.shade100,
          child: Icon(icon, color: Color(0xffFF620D), size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget textField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
