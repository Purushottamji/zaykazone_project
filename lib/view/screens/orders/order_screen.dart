import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/edit_profile/edit_profile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFF620D),
            elevation: 0,
            leading: const Icon(CupertinoIcons.back, color: Colors.white),
            title: const Text(
              "My Orders",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) => const [
                  PopupMenuItem(child: Text("Option 1")),
                  PopupMenuItem(child: Text("Option 2")),
                  PopupMenuItem(child: Text("Option 3")),
                ],
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: "Ongoing"),
                Tab(text: "History"),
              ],
            ),
          ),

          body: const TabBarView(
            children: [
              _OngoingOrdersList(),
              _CompletedOrdersList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OngoingOrdersList extends StatelessWidget {
  const _OngoingOrdersList();

  @override
  Widget build(BuildContext context) {
    return _OrdersBuilder(
      statusColor: Color(0xffFF620D),
      statusText: "Ongoing",
      showTrackButton: true,
    );
  }
}

class _CompletedOrdersList extends StatelessWidget {
  const _CompletedOrdersList();

  @override
  Widget build(BuildContext context) {
    return _OrdersBuilder(
      statusColor: Colors.green,
      statusText: "Completed",
      showTrackButton: false,
    );
  }
}

class _OrdersBuilder extends StatelessWidget {
  final String statusText;
  final Color statusColor;
  final bool showTrackButton;

  const _OrdersBuilder({
    required this.statusText,
    required this.statusColor,
    required this.showTrackButton,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Food",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              const Divider(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade300,
                      child: Image.asset(
                        "assets/images/whatsApp.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Pizza Hut",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "#162432",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "₹35.25 | 03 Items",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            if (showTrackButton)
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF620D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Track Order"),
                              ),

                            const SizedBox(width: 12),

                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color(0xffFF620D)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Rate Now",
                                style: TextStyle(color: Color(0xffFF620D)),
                              ),
                            ),

                            if (!showTrackButton) ...[
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const EditProfileScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF620D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text("Re-order"),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
