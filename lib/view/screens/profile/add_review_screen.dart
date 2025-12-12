//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/rating_api/rating_api.dart';
// import 'my_review_screen.dart';
// import 'package:zaykazone/rating_provider/rating_provider.dart';
//
// class AddReviewScreen extends StatefulWidget {
//   const AddReviewScreen({super.key});
//
//   @override
//   State<AddReviewScreen> createState() => _AddReviewScreenState();
// }
//
// class _AddReviewScreenState extends State<AddReviewScreen> {
//    double rating = 0;
//   final commentController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<RatingProvider>(context);
//
//     // int userId = 31;
//     //
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Review"),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Rate your experience", style: TextStyle(fontSize: 18)),
//
//               Row(
//                 children: List.generate(5, (index) {
//                   int pos = index + 1;
//                   return IconButton(
//                     onPressed: () {
//                       setState(() => rating = pos.toDouble());
//                     },
//                     icon: Icon(
//                       Icons.star,
//                       color: pos <= rating ? Colors.orange : Colors.grey,
//                     ),
//                   );
//                 }),
//               ),
//
//               SizedBox(height: 10),
//               Text("Rate your Product", style: TextStyle(fontSize: 18)),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: commentController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   hintText: "Write your review...",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Please write something" : null,
//               ),
//
//               SizedBox(height: 20),
//
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange),
//                   onPressed: () async {
//                     if (rating == 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Please give rating")),
//                       );
//                       return;
//                     }
//
//                     if (formKey.currentState!.validate()) {
//                       await provider.addReview(
//                         userId: RatingApi.storeId,
//                         productName: productName,
//                         rating: rating,
//                         experience: commentController.text,
//                         resId: 4,
//                       );
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyReviewsScreen(),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../rating_api/rating_api.dart';
import '../../../rating_provider/rating_provider.dart';
import 'my_review_screen.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double rating = 0;
  final commentController = TextEditingController();
  final productNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    RatingApi.storeUserId(context); // STORE USER ID
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RatingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Review"),
        backgroundColor: Color((0xffFF620D)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Name"),
              SizedBox(height: 8),
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter product name",
                ),
                validator: (v) => v!.isEmpty ? "Enter product name" : null,
              ),

              SizedBox(height: 20),
              Text("Rate your experience"),

              Row(
                children: List.generate(5, (index) {
                  int pos = index + 1;
                  return IconButton(
                    onPressed: () {
                      setState(() => rating = pos.toDouble());
                    },
                    icon: Icon(
                      Icons.star,
                      color: pos <= rating ? Colors.orange : Colors.grey,
                    ),
                  );
                }),
              ),

              TextFormField(
                controller: commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your experience",
                ),
                validator: (v) => v!.isEmpty ? "Enter experience" : null,
              ),

              SizedBox(height: 25),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color((0xffFF620D)),
                  ),
                  onPressed: () async {
                    if (rating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please give rating")),
                      );
                      return;
                    }

                    if (formKey.currentState!.validate()) {
                      await provider.addReview(
                        userId: RatingApi.storeId,
                        resId: 4,
                        productName: productNameController.text,
                        rating: rating,
                        experience: commentController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyReviewsScreen(),
                        ),
                      );
                    }
                  },
                  child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
