import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  final List<Map<String, dynamic>> orderSteps = const [
    {"title": "Order Placed", "subtitle": "Your order has been placed"},
    {"title": "Preparing", "subtitle": "Restaurant is preparing your food"},
    {"title": "On The Way", "subtitle": "Delivery partner is on the way"},
    {"title": "Delivered", "subtitle": "Your order has been delivered"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentStep = 2;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFF620D),
          elevation: 1,
          title: Text(
            "Track Order",
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.02),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              Expanded(
                child: ListView.builder(
                  itemCount: orderSteps.length,
                  itemBuilder: (context, index) {
                    bool isCompleted = index <= currentStep;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                            ),

                            if (index != orderSteps.length - 1)
                              Container(
                                width: 3,
                                height: size.height * 0.09,
                                color: isCompleted
                                    ? Colors.green
                                    : Colors.grey.shade300,
                              ),
                          ],
                        ),

                        SizedBox(width: size.width * 0.05),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderSteps[index]["title"],
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted
                                        ? Colors.green
                                        : Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  orderSteps[index]["subtitle"],
                                  style: TextStyle(
                                    fontSize: size.width * 0.035,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF620D),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "View Invoice",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.015),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xffFF620D), width: 2),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Back Home",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color:Color(0xffFF620D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
