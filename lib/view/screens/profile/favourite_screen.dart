// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({super.key});
//
//   @override
//   State<FavouriteScreen> createState() => _FavouriteScreenState();
// }
//
// class _FavouriteScreenState extends State<FavouriteScreen> {
//   List<Map<String, dynamic>> favFood = [
//     {
//       "name": "Cheese Pizza",
//       "img": "assets/images/pizza1.jpg",
//       "price": 249,
//       "isFav": true,
//     },
//     {
//       "name": "Chicken Burger",
//       "img": "assets/images/checken_burger.jpg",
//       "price": 180,
//       "isFav": true,
//     },
//     {
//       "name": "French Fries",
//       "img": "assets/images/french_fries.jpg",
//       "price": 120,
//       "isFav": true,
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Color(0xffFF620D),
//           title: Text(
//             "Favourites",
//             style: TextStyle(fontSize: 18.sp, color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//
//         body: favFood.isEmpty
//             ? Center(
//             child: Text(
//             "No favourite items",
//             style: TextStyle(fontSize: 16.sp, color: Colors.grey),
//           ),
//         )
//             : ListView.builder(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//           itemCount: favFood.length,
//           itemBuilder: (context, index) {
//             var item = favFood[index];
//
//             return Container(
//               margin: EdgeInsets.only(bottom: 15.h),
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12.r),
//                     child: Image.asset(
//                       item["img"],
//                       height: 70.h,
//                       width: 70.w,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   SizedBox(width: 12.w),
//
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item["name"],
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Text(
//                           "₹ ${item['price']}",
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xffFF620D),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         favFood.removeAt(index);
//                       });
//                     },
//                     child: Icon(
//                       Icons.favorite,
//                       color: Colors.red,
//                       size: 26.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/fevouritescreen_provider/favouritescreen_provider.dart';


class FavouriteScreen extends StatefulWidget {
  final int userId; // Logged-in user ID
  const FavouriteScreen({super.key, required this.userId});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavouriteProvider>(context, listen: false)
        .loadFavourites(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFF620D),
          title: Text(
            "Favourites",
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
          centerTitle: true,
        ),

        body: provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : provider.favourites.isEmpty
            ? Center(
          child: Text(
            "No favourite items",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding:
          EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          itemCount: provider.favourites.length,
          itemBuilder: (context, index) {
            var item = provider.favourites[index];

            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      item.restaurantImage,
                      height: 70.h,
                      width: 70.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.restaurantName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          item.restaurantAddress,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFF620D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      provider.removeFavourite(
                          item.fevoId, widget.userId);
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 26.sp,
                    ),
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
