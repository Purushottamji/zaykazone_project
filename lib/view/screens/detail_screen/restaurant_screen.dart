import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/detail_screen/restaurant_detail_screen.dart';

import '../../../controller/user_provider/restaurant_details_provider.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Map<int, bool> expandedMap = {};
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFF620D),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Future.microtask(() {
      Provider.of<RestaurantDetailsProvider>(
        context,
        listen: false,
      ).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RestaurantDetailsProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child:provider.allRestaurants.isEmpty
            ? Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator(backgroundColor: Color(0xffFF620D),)),
          ),
        )
            : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: provider.allRestaurants.length,
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            var item = provider.allRestaurants[index];
            bool isExpanded = expandedMap[index] ?? false;

            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.9,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => RestaurantDetailsScreen(
                                restaurant:
                                provider.allRestaurants[index],
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          item.image_url!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (c, o, s) => Icon(
                            Icons.broken_image,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    item.name ?? "",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFF620D),
                    ),
                  ),

                  Text(
                    item.description ?? "",
                    maxLines: isExpanded ? null : 2,
                    overflow:
                    isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      setState(() {
                        expandedMap[index] = !isExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          isExpanded ? "Show Less" : "Show More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Text(" ${item.rating}"),
                      SizedBox(width: 15),
                      Icon(
                        Icons.delivery_dining,
                        color: Colors.orange,
                      ),
                      Text(" ${item.delivery_charge}"),
                      SizedBox(width: 15),
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.orange,
                      ),
                      Text(" ${item.delivery_time}"),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
