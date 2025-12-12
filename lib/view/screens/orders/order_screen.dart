import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/edit_profile/edit_profile.dart';
import 'package:zaykazone/view/screens/profile/add_review_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffFF620D),
            foregroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "My Orders",
            ),
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

//
// ---------------- Ongoing Page ----------------
//

class _OngoingOrdersList extends StatelessWidget {
  const _OngoingOrdersList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _OngoingOrderCard();
      },
    );
  }
}



class _CompletedOrdersList extends StatelessWidget {
  const _CompletedOrdersList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _HistoryOrderCard();
      },
    );
  }
}



class _OngoingOrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
              Text("Food",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text(
                "Ongoing",
                style: TextStyle(
                    color: Color(0xffFF620D),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
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
                    "assets/images/pizza1.jpg",
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
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "₹35.25 | 03 Items",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 15),


                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFF620D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("TrackOr"),
                        ),

                        const SizedBox(width: 10),

                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(),));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xffFF620D)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Rate Now",
                            style: TextStyle(color: Color(0xffFF620D)),
                          ),
                        ),
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
  }
}


class _HistoryOrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
              Text("Food",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text(
                "Completed",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
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
                    "assets/images/pizza1.jpg",
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
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "₹35.25 | 03 Items",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 10,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xffFF620D)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Rate Now",
                            style: TextStyle(color: Color(0xffFF620D)),
                          ),
                        ),

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
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Re-order"),
                        ),
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
  }
}

